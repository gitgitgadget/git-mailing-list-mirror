From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH v5 5/7] Add ref rename support to the branch dialog
Date: Fri, 12 Jun 2009 13:02:28 -0700
Message-ID: <20090612200228.GR16497@spearce.org>
References: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com> <1244668945-12622-1-git-send-email-robin.rosenberg@dewire.com> <1244668945-12622-2-git-send-email-robin.rosenberg@dewire.com> <1244668945-12622-3-git-send-email-robin.rosenberg@dewire.com> <1244668945-12622-4-git-send-email-robin.rosenberg@dewire.com> <1244668945-12622-5-git-send-email-robin.rosenberg@dewire.com> <1244668945-12622-6-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 22:02:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFCxR-0005Uo-Jw
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 22:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbZFLUC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 16:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbZFLUC0
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 16:02:26 -0400
Received: from george.spearce.org ([209.20.77.23]:43252 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbZFLUC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 16:02:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BB0FC381FD; Fri, 12 Jun 2009 20:02:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1244668945-12622-6-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121446>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
> index 9aad95b..28105af 100644
> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
> @@ -284,43 +311,81 @@ protected void createButtonsForButtonBar(Composite parent) {
>  			newButton.setFont(JFaceResources.getDialogFont());
>  			newButton.setText(UIText.BranchSelectionDialog_NewBranch);
>  			((GridLayout)parent.getLayout()).numColumns++;
> +			Button renameButton = new Button(parent, SWT.PUSH);
> +			renameButton.setText("&Rename");

Not localized.

> +							if (renameRef.rename() != Result.RENAMED) {
> +								MessageDialog.openError(getShell(),
> +										"Rename failed",

Not localized.

-- 
Shawn.
