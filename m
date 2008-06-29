From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: Is there a way to diff between a local repository and a remote one?
Date: Sun, 29 Jun 2008 15:19:22 +0300
Message-ID: <ce513bcc0806290519u2e97f276t9fbe8c87715488ea@mail.gmail.com>
References: <ce513bcc0806290429r1982fbf2i4c9a8258bc8db3c@mail.gmail.com>
	 <4867783C.1010408@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Boaz Harrosh" <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 14:20:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCvtG-0005gi-JG
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 14:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbYF2MTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 08:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753790AbYF2MTY
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 08:19:24 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:16099 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbYF2MTX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 08:19:23 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1240808rvb.1
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 05:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=g3nwZI/6xpYIwVDDf+BaB7rhbM1d2FPl8iQLvL5XBeM=;
        b=iYqzra4dx6AHXnEl6GK3xMOR0FpMEQjcnmWbCNWdxolNGJEfr8K+lRRQ+RYl4gnJIq
         NNoUZDbIf1f+tgepCyUDzVom9j5ZqQjA/ZAFaRIKNle1ALKarAsdRchpRkPh0U40Z21A
         CYSkyFb9/U4VPChtVmH/2CMirF4cMLH1k1Zp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lgoGhvT+EfRey4YN2JzgzxvpKZVc9zSJFfnl+q7YDdiE30nGaHCeSpTSBjmoPBQNVC
         +lm9/IhvCo1QFMAOtHWG3q0PhBu3tm/UO41H99u8WmvxEvSescZ9mCtAywt4Z4OPOSZP
         9srhvxGyXMQJ03GKeZjD1gDT7AjJ0075CRLSw=
Received: by 10.141.171.1 with SMTP id y1mr1979865rvo.86.1214741962519;
        Sun, 29 Jun 2008 05:19:22 -0700 (PDT)
Received: by 10.140.136.4 with HTTP; Sun, 29 Jun 2008 05:19:22 -0700 (PDT)
In-Reply-To: <4867783C.1010408@panasas.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86797>

On Sun, Jun 29, 2008 at 2:55 PM, Boaz Harrosh <bharrosh@panasas.com> wrote:
> Erez Zilber wrote:
>> I could clone the remote repository and use Linux's diff, but I prefer
>> to do it the right way (if possible).
>>
>> Thanks,
>> Erez
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> I use git-remote add
>
> and git-diff that_remote/that_branch
>
> then from time to time "git-remote update" to update on remote progress
>
> Boaz

thanks!
