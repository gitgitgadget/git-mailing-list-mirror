From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Lets avoid the SHA-1 term (was [doc] User Manual Suggestion)
Date: Mon, 27 Apr 2009 02:38:40 +0300
Message-ID: <94a0d4530904261638o6cbda368p4f3aa641505a6768@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Abrahams <dave@boostpro.com>,
	Michael Witten <mfwitten@gmail.com>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>
To: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 10:31:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyDzX-0003tn-4U
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 01:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbZDZXim convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 19:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbZDZXim
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 19:38:42 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47864 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbZDZXil convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2009 19:38:41 -0400
Received: by fxm2 with SMTP id 2so2014110fxm.37
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 16:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=jpBAcuMtOVP2Kx9MuWPfhITq3bOrKy+c8lJm7vaeaAk=;
        b=dP+IlLhLUDBlyR9dsRu1AOuBR8GmV+BL2Whj5pRo6waJV9586UmejYkrKKGA0RDAfb
         rJbuvQjXAZqAkcK+Ip0OhDJcWoF4rcN7KKahvBwY0jSkh0c6F8/ifYZfXZizLWZLV/pt
         WYrt+LZB17KHd+NMG2kv6T0J/uZrMOcPb9+8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=hOkdmDrZljZlygp9f1F0ARDK+tIq3vYXPJtncn3dOH+Brw3dkacVq1AvrBEPXWqKtd
         G9eWWqW8q1BlpZnjgqZWdFm3kD1PSMb7ihfHNHwvZVtfQu+CPEWgpLUzdy9NxSQSlM5T
         SJqu2mThyOa+TFWmYr7382X8lMTx0lLhwZ/qM=
Received: by 10.86.80.5 with SMTP id d5mr2721107fgb.59.1240789120513; Sun, 26 
	Apr 2009 16:38:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117609>

2009/4/27 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.04.24 20:48:57 -0400, David Abrahams wrote:
>>
>> On Apr 24, 2009, at 8:01 PM, Michael Witten wrote:
>>
>>>> What's wrong with just calling the object name "object name"?
>>>
>>> What's wrong with calling the object address "object address"?
>>
>> Neither captures the connection to the object's contents. =C2=A0I th=
ink
>> "value ID" would be closer, but it's probably too horrible.
>
> I think I asked this in another mail, but I'm quite tired, so just to
> make sure: What do you mean by "value"? I might be weird (I'm not a
> native speaker, so I probably make funny and wrong connotations from
> time to time), but while I can accept "content" to include the type a=
nd
> size of the object, the term "value" makes me want to exclude those
> pieces of meta data. So "value" somehow feels wrong to me, as the has=
h
> covers those two fields.

Just to summarize.

Do you agree that SHA-1 is not the proper term to choose?

Do you agree that either 'id' or 'hash' would work fine?

Personally I think there's an advantage of choosing 'hash'; if we pick
'id' then the user might think that he can change the contents of the
object while keeping the same id, if we pick 'hash' then it's obvious
the 'id' is tied to the content and why.

--=20
=46elipe Contreras
