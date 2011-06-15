From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Wed, 15 Jun 2011 13:26:54 +0200
Message-ID: <BANLkTik+oUb1QpVTwJfB30_8FsW=4ZVTxA@mail.gmail.com>
References: <4DF87B42.1020004@st.com> <m3ei2vv0nw.fsf@localhost.localdomain> <4DF891CC.1040700@st.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: viresh kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 13:27:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWoG4-0006tj-1S
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 13:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab1FOL1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 07:27:35 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47893 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab1FOL1e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 07:27:34 -0400
Received: by pvg12 with SMTP id 12so190694pvg.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 04:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=GAcKyrVh68zN2flvGpyMBaa4tRCZAS080vAoBKUC2Ss=;
        b=k122N0aGYXOcEV7SrsbY+uZNxzyi6pERn/6HhuGR/V3UgDg65pcTPw02YgHamnhAam
         B/t6ZwZGapdvkL7TxzgLQykio0a6RN7IMr0STdLGPA2SHASPZmF7IOgemqFBZBBrs3u6
         F8jl/Phn4h3ue+pBk9WjE1mBbCqnHNIZ2nZvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=eE/d3LZIhQGFCWE8oTHPSnwA1aydajeUG7f/NNxYTA4vEOkpb2SO+ea0l7JeKz6gXG
         eGtz98QUahdWuq20Hh7MbjtJS5dLwUXb33VmFolNOXii537Uqp27X21rU3Dti7QzHeRS
         /JQKpEPQCIx9hojlM/Vv/DSwqH8OkJrnrqCVg=
Received: by 10.68.39.132 with SMTP id p4mr157113pbk.369.1308137254084; Wed,
 15 Jun 2011 04:27:34 -0700 (PDT)
Received: by 10.68.50.197 with HTTP; Wed, 15 Jun 2011 04:26:54 -0700 (PDT)
In-Reply-To: <4DF891CC.1040700@st.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175824>

On Wed, Jun 15, 2011 at 1:04 PM, viresh kumar <viresh.kumar@st.com> wrote:
> On 06/15/2011 04:10 PM, Jakub Narebski wrote:
>> BTW. what filesystem do you use?
>>
>
> It was FAT on memory stick as FAT is also there in Windows PC.
> More observation: All files marked modified had only changes in file permissions.
> i.e. 755 instead of 644. chmod doesn't work with FAT so can't change there permissions
> now.
>
> Problem is not only for symlinks but standard c files too.

Sounds like you should try "git config core.filemode false":

"core.fileMode:
     If false, the executable bit differences between the index and
the working copy are ignored; useful on broken filesystems like FAT"

(from from http://kernel.org/pub/software/scm/git/docs/git-config.html)
