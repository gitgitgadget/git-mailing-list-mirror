From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fallback on _NSGetExecutablePath to get the executable
 path if using argv[0] fails
Date: Mon, 29 Nov 2010 12:50:30 -0600
Message-ID: <20101129185030.GB9441@burratino>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com>
 <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com>
 <20101129171211.GL8037@burratino>
 <37CD335A-00A7-4074-BD39-4FCDEEB3D083@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@apple.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 19:50:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN8oH-0006lk-5d
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 19:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab0K2Suk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 13:50:40 -0500
Received: from mail-fx0-f66.google.com ([209.85.161.66]:34533 "EHLO
	mail-fx0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab0K2Suj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 13:50:39 -0500
Received: by fxm9 with SMTP id 9so2015044fxm.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 10:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LaA/uJRX6jBgjG5hg1H/96uQ1W01D17fLQ4Z4nK4rr8=;
        b=JybvO65MHUY0JkE6QOvPxwo8bvComDNRWbkTENBfSFAC8sJTMfilZ43KX0aWwZxmH1
         9sfkRF2gaEfAYHP6BUV6nu+tG+WVUgwRMys11KBnW4ApKMeoNzjWMuI7+YpQpCYRPku2
         ts2FQFfgYrCRMn4CDcZcd2fx0Hy5pO996y0VM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Q3FTy3KVYa9GkZURU+0kIGb4xXadQAU9+qt2RyCkrP/L8yI7ZLpSIcQy4GZX8hoNVG
         egxR6tSFsGdYnapzCAHyH1r+I6mAJV6/3fNCHdX3ZzD4GsIxzkOzbzsCyFm7aQX6m2t9
         P6AzVrE4ozmqyMedj5nAIVDAqMtdShZwAOwR4=
Received: by 10.223.93.204 with SMTP id w12mr5644903fam.103.1291056638515;
        Mon, 29 Nov 2010 10:50:38 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id e6sm1328566fav.8.2010.11.29.10.50.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 10:50:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <37CD335A-00A7-4074-BD39-4FCDEEB3D083@apple.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162414>

Jeremy Huddleston wrote:
> On Nov 29, 2010, at 12:12, Jonathan Nieder wrote:

>> The section "2) #ifdefs are ugly" of
>> linux-2.6/Documentation/SubmittingPatches explains the rationale.
>
> I agree, but I don't really see a way around it here since this API is specific to OS X.

Did you actually read that section? :)
