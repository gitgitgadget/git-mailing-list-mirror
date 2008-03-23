From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 07:45:07 -0600
Message-ID: <51419b2c0803230645l5b07bbf5h9cbf9b6f47373efa@mail.gmail.com>
References: <47E64F71.3020204@jwatt.org>
	 <alpine.LSU.1.00.0803231401340.4353@racer.site>
	 <47E658D3.1060104@jwatt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jonathan Watt" <jwatt@jwatt.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 14:45:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQWE-0000eU-77
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 14:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309AbYCWNpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 09:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757002AbYCWNpJ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 09:45:09 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:56101 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756096AbYCWNpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 09:45:08 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2496855wff.4
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 06:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=X9baX3XgEIWzpZ8F/Kh90ytt/pijthhu1Y6yF50AQWA=;
        b=QZuIRflNZL7ryTHRidmcncRKVr2OMAKLzFYSqsDtAEIZ2JiHlMPlni+lIqu6uY5NIifcMgA2rmfUS5R8ptqMEFsr5Hv4RvTldR717d+a/IJSSOvRfTTGIkjVO13GBGpf0V0LVwDa5QrbulqJrEvZsQTD7dc3gNBFHXELsBGqQOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VJJ9M1UZj7+JfEe3W3TM4sGf2AKCN+M4LgTJhMB7w8ciLDk8JCKqdoaZ8M9/gdhJ7atSwoovB/GGWjKTF/kZUnofIhIYYfdTtlP6ur+ZgMDgd8xBuGS9j7eWgm+G/QvyYaQl1LNVfUKOzpHVmFtjLTFVjZoyLRTLB86Ys5zYFII=
Received: by 10.114.27.20 with SMTP id a20mr9661431waa.101.1206279907940;
        Sun, 23 Mar 2008 06:45:07 -0700 (PDT)
Received: by 10.114.205.19 with HTTP; Sun, 23 Mar 2008 06:45:07 -0700 (PDT)
In-Reply-To: <47E658D3.1060104@jwatt.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77894>

On Sun, Mar 23, 2008 at 7:19 AM, Jonathan Watt <jwatt@jwatt.org> wrote:
> Johannes Schindelin wrote:
>  > Hi,
>  >
>  > On Sun, 23 Mar 2008, Jonathan Watt wrote:
>  >
>  >> There seems to be a problem with git-push when the working copy of the
>  >> directory being pushed to came from the magic revision HEAD, but not
>  >> when the working copy came from some other revision.
>  >
>  > http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73
>  >
>  > Sidenote: I am constantly amazed how people have no problem accepting that
>  > a CVS-Server has no working directory, but all of a sudden think that a
>  > Git-server should have one, and auto-update it.
>
>  Hi Dscho. I think you've misread my email. (Or not read it. ;-)) I do not expect
>  git-push to update the working copy of the repository being pushed to. In fact
>  my complaint would be more that it *does* appear to modify the working copy
>  (well, not so much modify the working copy as get confused about which revision
>  the working copy came from) when the working copy came from HEAD.

Ah, I hadn't thought of it that way before.  I think you are
suggesting that pushing to the active branch of a repository with an
associated working copy should cause the HEAD to become detached.  Is
that right?  That's an interesting new twist to this old problem that
I personally haven't seen before (though I am kind of new and have
only had a little time to dig up archives about this problem).  Hmm...
