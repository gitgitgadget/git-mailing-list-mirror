From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor  with no changes written
Date: Wed, 3 Feb 2010 19:21:18 +0100
Message-ID: <1088CD70-9D6E-4B97-9A46-BDDE1535B703@wincent.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com> <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com> <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com> <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com> <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com> <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de> <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com> <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com> <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com> <vpqeil2kc6b.fsf@bauges.imag.fr> <76c5b8581002030745g634d6ec1hb9e87b687e58e521@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 19:53:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NckM5-00037T-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 19:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757533Ab0BCSxH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 13:53:07 -0500
Received: from outmail136040.authsmtp.co.uk ([62.13.136.40]:51753 "EHLO
	outmail136040.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757532Ab0BCSxE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 13:53:04 -0500
X-Greylist: delayed 1892 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2010 13:53:04 EST
Received: from mail-c187.authsmtp.com (mail-c187.authsmtp.com [62.13.128.33])
	by punt9.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o13ILSoc009075;
	Wed, 3 Feb 2010 18:21:28 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o13ILP7m033391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Feb 2010 18:21:26 GMT
Received: from [192.168.1.2] (124.Red-88-3-77.dynamicIP.rima-tde.net [88.3.77.124])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id o13ILJF7024022
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 3 Feb 2010 13:21:22 -0500
In-Reply-To: <76c5b8581002030745g634d6ec1hb9e87b687e58e521@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: f0ed521f-10f0-11df-ab46-001185d377ca
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJCkVH ah0dAFdZdwdEHAkR Am4BWVVeUls/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSwRreGBh AUMeURpxfgQIe3hy bU4sCHAOCEF4dBBg Q04CFXAHZDM2dTFN VEZFdwNVcQtPKhxC bQMuGhFYa3VsFB8X Kkd2d3o+PCkXIyNQ RwARZRdXSEMGGDJ2 DxsFGDAuAVZBDzoz IhpuJ04dAEcXPQ0u MVZpVF4ZLxgIQkVB Hl1NSCleb1IBTiwk ABgSQlQfDCFQR08A 
X-Authentic-SMTP: 61633436303433.1000:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138862>

El 03/02/2010, a las 16:45, Eugene Sajine escribi=F3:

> On Wed, Feb 3, 2010 at 2:31 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Eugene Sajine <euguess@gmail.com> writes:
>>
>>> Thank you, but I'm not wrong, as i described the exact same thing
>>> somewhere in my second or third message, without even knowing the
>>> implementation details. I understand the reason WHY it is like it =20
>>> is,
>>> i just don't like it as it is inconsistent and IMHO incorrect.
>>
>> Just try:
>>
>> Create a file.
>> 1) Launch emacs, save and quit.
>> 2) Launch emacs, don't save, and quit.
>>
>> From outside, it's EXACTLY the same thing. In the first case, emacs
>> will just tell you "no change need to be saved" and quit, in the
>> second, it'll quit. Try deleting the file in the meantime, it won't
>> change the behavior.
>>
>> Now, what would you do about this? Ignore Emacs and force people to
>> use vi?
>>
>> People have been spending a whole thread to explain you that it's no=
t
>> going to work. I think it'll either be time to acknowledge that, or =
=20
>> to
>> learn C and write a patch. Or perhaps try to write it in Java to
>> understand why it doesn't work.
>>
>> --
>> Matthieu Moy
>> http://www-verimag.imag.fr/~moy/
>>
>
> Tell me you're not serious, please;) I'm working with computers for
> more than 20 years and I do understand how editors are opening files.
> If you are serious though...:
>
> Please, do not assume i don't understand that file opened in editor
> and saved with no changes will be the same as not saved.
>
> Please, do not assume i don't understand that current implementation
> does not allow to correctly abort by simply quiting the editor,
> because it uses the file content only to verify if it can proceed.
>
>
> I will stop trying to explain the problem here, but the solution, tha=
t
> i think should work:
>
> The solution should be as Avery proposed - to monitor file
> modification timestamp as well as the content.
> Timestamp should be remembered by git when editor is fired up and the=
n
> checked when you're exiting the editor. If it is the same - it means
> that user canceled the whole operation by not confirming the file
> content by save. If the timestamp is bigger than the saved one and th=
e
> message is not empty - we can proceed. Something like that.
>
> And finally:
>
> I DO highly appreciate everybody's time spent on every discussion and
> particularly this one. I ask you to excuse me if i was failing to
> properly express my thoughts or if i was too emotional at times.

Perhaps you could invest a little time actually reading what people =20
have written. Your proposal won't work because in the case where the =20
user wants to keep the commit message without any modifications many =20
editors won't touch the file even if people explicitly save it.

Wincent
