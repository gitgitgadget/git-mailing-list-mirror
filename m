From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git diff --cc bug
Date: Mon, 16 Jun 2008 13:48:33 +0200
Message-ID: <48565311.9070407@viscovery.net>
References: <48510CFA.3060101@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060602050807010401050506"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 13:49:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8DDH-0002UN-6U
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 13:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbYFPLsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 07:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbYFPLsf
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 07:48:35 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43490 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbYFPLsf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 07:48:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K8DCL-0005iv-0i; Mon, 16 Jun 2008 13:48:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A4A916D9; Mon, 16 Jun 2008 13:48:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48510CFA.3060101@viscovery.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85181>

This is a multi-part message in MIME format.
--------------060602050807010401050506
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Johannes Sixt schrieb:
> @@@ -635,31 -865,171 +641,169 @@@ void CValuesView::EraseVa...
>  -LRESULT CValuesView::OnOptionsChanged(WPARAM, LPARAM)
>  -{
>  -	if (GetDocument()->ShowPointerValues()) {
>  -		// invalidate values in the display
>  -		CPoint pt(m_x, m_y);	// will be erased
>  -		InvalidateValues();
>  -		FindFmtStrings();
>  -		Update(pt.x, pt.y);
>  -	}
>  -	return 0;
>  -}
>  -
>   void CValuesView::OnUpdate(CView* pSender, LPARAM lHint, ...
>   {
>   	switch (lHint) {
> ++<<<<<<< HEAD:SomUI/ValuesWnd.cpp
> ++=======
> + 	case UPDATE_MONITORFRAME:
> + 		{
> (hunk truncated for exposition)
> 
> Notice that there are no context lines at the beginning of the second
> hunk. I would not have expected this, and I think it's a bug in git diff.

Attached is a tar.gz of a repository the exposes the bug when a simple
'git diff' is run. If -U2 is added, the removals at the beginning of the
hunk are not shown, as expected. If -U4 is added, more changes are shown
at the beginning of the hunk, which happen to be separated by 3 lines of
context from the part that is unexpectedly visible with -U3.

-- Hannes


--------------060602050807010401050506
Content-Type: application/gzip;
 name="git-diff-cc-bug.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-diff-cc-bug.tar.gz"

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
--------------060602050807010401050506--
