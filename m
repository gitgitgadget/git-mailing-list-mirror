From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] bash completion: Add long options for 'git describe'
Date: Fri, 25 Jul 2008 15:15:32 +0200
Message-ID: <20080725131532.GB6701@neumann>
References: <1216980170-14136-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 25 15:17:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMN9u-0001L1-Ll
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 15:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbYGYNPe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 09:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752899AbYGYNPe
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 09:15:34 -0400
Received: from francis.fzi.de ([141.21.7.5]:42628 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752865AbYGYNPe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 09:15:34 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 25 Jul 2008 15:15:31 +0200
Content-Disposition: inline
In-Reply-To: <1216980170-14136-1-git-send-email-trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 25 Jul 2008 13:15:31.0805 (UTC) FILETIME=[83EEB0D0:01C8EE58]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90046>

Hi,

On Fri, Jul 25, 2008 at 12:02:50PM +0200, Thomas Rast wrote:
> ---
Signed off by?

>  _git_describe ()
>  {
> +	__git_has_doubledash && return
This line is superfluous, because 'git describe' does not have any path
arguments.

G=E1bor
