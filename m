From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Git Bug report
Date: Thu, 6 Oct 2011 12:48:14 -0400
Message-ID: <CABURp0qw55bKNEjAnn5UHc5nPqiF4MEyG4SmHZf3qJEDFaug2g@mail.gmail.com>
References: <1317763443.17036.15.camel@skyplex> <20111005072235.GA12600@kolya>
 <7vlisz8jur.fsf@alter.siamese.dyndns.org> <20111006003318.GA9015@goldbirke>
 <7vobxv3q49.fsf@alter.siamese.dyndns.org> <20111006010940.GR2208@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Federico Lucifredi <federico@canonical.com>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:48:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBr7j-0007Of-MX
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988Ab1JFQsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 12:48:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48945 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935224Ab1JFQsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 12:48:35 -0400
Received: by wyg34 with SMTP id 34so3025972wyg.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1y5GlKmfnbNs3lVKhQXE8Pu5kWUlm84knKLGbZsQAoI=;
        b=OEh5hnsRoqqT0gpYoN0tbGaT1s2fbUzVLlVYH2EnRu0FrA4/+wBddFox3krpQ6Cyq8
         bOXm5qre9KRPpgbpyM7I90LA51deWuBITQHV7UzPYzJBZ3SDJ/ILLtlXVoeqRfC/a6Qf
         0SEVFDygdQl76BBOlxIUO/umHwiClmM49KuaU=
Received: by 10.216.133.129 with SMTP id q1mr1260000wei.87.1317919714230; Thu,
 06 Oct 2011 09:48:34 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Thu, 6 Oct 2011 09:48:14 -0700 (PDT)
In-Reply-To: <20111006010940.GR2208@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182972>

On 10/5/11, SZEDER G=E1bor <szeder@ira.uka.de> wrote:
> On Wed, Oct 05, 2011 at 05:44:54PM -0700, Junio C Hamano wrote:
>> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>>
>> > And what about unreadable .git files?
>>
>> Having then inside a working tree is so sick that I do not think it
>> deserves consideration.
>
> I'm not sure why is this any different than having a .git directory
> that is not a repository inside a working tree.

What should happen here? Ignore it and keep searching? Or fail?

I just added some common gitfile detection code and I noticed that the
oddball case now is the one that dies on error rather than continuing
to search for alternate explanations. I left the oddball behavior
assuming it is desireable, but now you have me rethinking it.

Phil
