From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in gittutorial
Date: Wed, 27 Aug 2008 10:26:59 +0200
Message-ID: <4d8e3fd30808270126x3c34baa5q3e0d6f34bd24188d@mail.gmail.com>
References: <20080825215023.11822a20@paolo-desktop>
	 <loom.20080825T200956-169@post.gmane.org>
	 <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808251512x126502bj5f154b58d7ae51a2@mail.gmail.com>
	 <7vy72kbov4.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808260116o543f1a61sd05070fe02f69d2e@mail.gmail.com>
	 <7viqtnabld.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808270058g3379174bn9efe09f550aa0721@mail.gmail.com>
	 <402731c90808270121t5c09efd1m3b60a1ad15f8f705@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Eric Raible" <raible@gmail.com>, git@vger.kernel.org
To: "David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 10:28:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYGNt-0006xV-2a
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 10:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbYH0I1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 04:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754713AbYH0I1E
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 04:27:04 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:13522 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605AbYH0I1B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 04:27:01 -0400
Received: by qb-out-0506.google.com with SMTP id f11so318235qba.17
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eM8Pyv8xDZt61EYUb9Ot/E3cv8L9pUF2VdCYrU6AsjE=;
        b=psT1BqIfMYexL8H0ACyfvqS7K0vKBi61O/fRpZijHKkhGGU5vyaMRQDCWqlSHa2RJ3
         u30OWHMml6BhFzEfrGxrImek8le/YBjuA1YELt5bP2K9TndDal0HsB0FCoCGDaMnyI5b
         DuVV9W5X78E8vsROPJIkl9lyv2uzhjs8v6egM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JcqiXEpEK0nrJsHKeh2LPfMb4SdD4dmCfv7/CGkYDCpkHWgJCE8U+prnRg7vNAfaSh
         RObqXaox4rfetzMIEnHtJ1Inap0MfsESA5Y4gQrrqDnhcbCd4OiSPFsTPGHTScjTgfZl
         XSXnw86i9HuADWnyABw5UWLl4vxD8oLpZF/P0=
Received: by 10.114.26.18 with SMTP id 18mr5640164waz.162.1219825619714;
        Wed, 27 Aug 2008 01:26:59 -0700 (PDT)
Received: by 10.114.135.2 with HTTP; Wed, 27 Aug 2008 01:26:59 -0700 (PDT)
In-Reply-To: <402731c90808270121t5c09efd1m3b60a1ad15f8f705@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93873>

On Wed, Aug 27, 2008 at 10:21 AM, David Aguilar <davvid@gmail.com> wrote:
> On Wed, Aug 27, 2008 at 12:58 AM, Paolo Ciarrocchi
> <paolo.ciarrocchi@gmail.com> wrote:
>>
>> What do you think of this whitespace damaged patch?
>> BTW, does anybody know if/how to inline a patch using the web
>> interface of Gmail?
>
> You don't -- the preferred method is git send-email:
>
> http://git.or.cz/gitwiki/GitTips#head-a015948617d9becbdc9836776f96ad244ba87cb8
>
> The gmail instructions on the wiki work like a charm.

Don't get me wrong, when I'm at home I use a real MUA and
I know how to send out patches but I'm often in places where I can
only access to the gmail web interface, hence the question.

And my sentence:
">> What do you think of this whitespace damaged patch?"
was only because if Junio/thelist like the doc change then I'll wrote
a proper changelog and send out the patch using my MUA ;-)

Thanks.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
