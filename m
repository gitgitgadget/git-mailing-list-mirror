From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Fri, 20 Jul 2012 12:01:48 +0200
Message-ID: <50092C8C.3000305@alum.mit.edu>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jul 20 12:09:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsA8o-0007eu-Fn
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 12:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab2GTKIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 06:08:54 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:48530 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752885Ab2GTKIx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2012 06:08:53 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jul 2012 06:08:52 EDT
X-AuditID: 1207440e-b7f036d0000008b5-6d-50092c8e13c1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.25.02229.E8C29005; Fri, 20 Jul 2012 06:01:50 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q6KA1mfp028968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Jul 2012 06:01:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsUixO6iqNunwxlgMOeWtsXxp9dZLLqudDNZ
	NPReYba49Hk9q0XjkyKL2yvmM1usfnyH3eL92f/MDhwef99/YPLYOesuu8fEL8dZPS5eUvb4
	vEnO48Dlx2wBbFHcNkmJJWXBmel5+nYJ3BkXW9UKDrBWHP95mbGBcQ9LFyMnh4SAicTZnkVs
	ELaYxIV768FsIYHLjBJ/u+0g7ONMEpfeZoLYvALaEhc3d7B2MbJzsAioSkxJAImyCehKLOpp
	ZgKxRQVCJNZ8m8IIUS0ocXLmE7BNIgISEr2LVoLZzAJHmCS2vPcHsYUFnCVWztnBBLHJWeJD
	4x+wCzgFXCRuPX8CFOcAqreW+La7CKJVXmL72znMExgFZiHZMAuhahaSqgWMzKsY5RJzSnN1
	cxMzc4pTk3WLkxPz8lKLdI31cjNL9FJTSjcxQoKfbwdj+3qZQ4wCHIxKPLyTkjgChFgTy4or
	cw8xSnIwKYnyWmpzBgjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4a0QA8rxpiRWVqUW5cOkpDlY
	lMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4d4AMFSxKTU+tSMvMKUFIM3FwggznkhIpTs1L
	SS1KLC3JiAdFZ3wxMD5BUjxAe+eCtPMWFyTmAkUhWk8x2nNce3jrFiPHky8gcsGue0Cy+wuQ
	FGLJy89LlRLnXQbSJgDSllGaB7cUlg5fMYoDw0CYdx1IFQ8wlcLNfgW0lgloLXcxG8jakkSE
	lFQDo0QYC5Oo8+OeZgPBupcVh7kTDNYv4DxxN47z0sxFj3d+dph9Jnd3z2oPNTPZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201765>

On 07/14/2012 08:59 AM, mhagger@alum.mit.edu wrote:
> Add a new Python script, contrib/hooks/post-receive-multimail.py, that
> can be used to send notification emails describing pushes into a git
> repository.  [...]

Thanks to everybody for your feedback.  I will try to incorporate it in 
a new version of the script, which I will put forward as a replacement 
for contrib/hooks/post-receive-email rather than as an alternative.  But 
I have very little open-sourcing time these days, and will be on 
vacation next week, so please be patient (or feel free to lend a hand if 
you are so inclined).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
