From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2011, #06; Sun, 30)
Date: Mon, 31 Jan 2011 16:08:09 +0100
Message-ID: <AANLkTik4jZWLt6T-SwMgK94FJ77ujyUC4-oFD46-eqN=@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 16:09:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjvNP-0004wy-DZ
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 16:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996Ab1AaPIu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 10:08:50 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:42683 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab1AaPIu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 10:08:50 -0500
Received: by yib18 with SMTP id 18so1990465yib.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 07:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=edAuRA1rbxzhAMWMUpDPKH3rwggtr9a5YS+eK/5yzLw=;
        b=CIclZiQ8DMpuQh9jG2V9KNxAPs2Q9hUJxVG05bvxETxLqYXB4/PwOaSjVdvjjLdyHe
         Y6bRDNK2SJYK/b2zc7HRVoDpmGhBemCVxi0Ey2kUf5g0CpBy1nverVjlf/qlZOy+SXaq
         asQTYQ/yP828uTuBO+hTZ8MZAiGbCYQdAseMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uTq0k25LFz907yT1hf6U+9ges/Mn6k42s4jDtWNrKyULN4aVztfr1m4ffTpC/sSND0
         80Cf5rzqhNRMIe/uNHW+JykUqufMJN4xFRHQDScJJNuFciIyyyLPmlYjFMJj/OD2j4Fo
         v9jsis4UGKT7JHZ0R1/6oCqn/0gTF6OV0cZZ8=
Received: by 10.150.58.2 with SMTP id g2mr3310416yba.397.1296486529208; Mon,
 31 Jan 2011 07:08:49 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Mon, 31 Jan 2011 07:08:09 -0800 (PST)
In-Reply-To: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165731>

Heya,

On Mon, Jan 31, 2011 at 06:53, Junio C Hamano <gitster@pobox.com> wrote=
:
> 1.7.4 is out. I'd like to stop and calm the tree down for a few days
> so that we can catch any brown-paper-bag bugs before moving things
> forward, and then open the floodgate for the next cycle, which I am
> inclined to designate as "We would have done these differently if we
> were creating git from scratch with the experience we have and wisdom
> we have gained" cycle, allowing minor backward incompatibilities,
> somewhat like 1.6.0 but not so drastic. =C2=A0The result would probab=
ly
> be called 1.8.0--the details in a separate message.

Nice, is this based on the topics that are currently cooking, or on
people having indicated an intent to submit such patches?



Now that we're past 1.7.4., perhaps it's time to resurrect a dead
thread. From a past "What's cooking":

On Tue, Dec 14, 2010 at 03:20, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, Dec 13, 2010 at 09:34, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>
>>> Needs a bit more minor work to get the basic code structure right.
>>
>> And I'm still not sure (see earlier replies to "What's Cooking" post=
s)
>> what needs to be done to make it better.
>
> One open question was why you do not want to move 'LIB_OBJS +=3D gett=
ext.o'
> away from the LIB_OBJS section down to the configuration evaluation
> section, i.e., why gettext.o would be different from block-sha1/sha1.=
o.

=C3=86var, you didn't respond to that message. Junio, do I understand
correctly that if this problem is addressed the topic is ready to be
merged to next?

--=20
Cheers,

Sverre Rabbelier
