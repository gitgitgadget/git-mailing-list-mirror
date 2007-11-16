From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] Fix and improve t7004
Date: Fri, 16 Nov 2007 22:47:12 +0100
Message-ID: <225E846F-7EDB-4B57-923C-909F3F000D82@lrde.epita.fr>
References: <7vlk8yx9rp.fsf@gitster.siamese.dyndns.org> <1195244917-25659-1-git-send-email-mh@glandium.org> <EEE710FA-0408-489F-8128-B4C1F06D34FF@lrde.epita.fr> <20071116211148.GA28966@glandium.org> <EC3B30DC-E81C-4ECA-BE7F-F237E1338603@lrde.epita.fr> <20071116213538.GA30076@glandium.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-51-46583865"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:48:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It92d-0000vF-A8
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 22:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935435AbXKPVra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 16:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765479AbXKPVr3
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 16:47:29 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:58084 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935374AbXKPVr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 16:47:28 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1It926-0000Aw-4I; Fri, 16 Nov 2007 22:47:26 +0100
In-Reply-To: <20071116213538.GA30076@glandium.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65251>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-51-46583865
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 16, 2007, at 10:35 PM, Mike Hommey wrote:
> On Fri, Nov 16, 2007 at 10:31:15PM +0100, Benoit Sigoure wrote:
>> On Nov 16, 2007, at 10:11 PM, Mike Hommey wrote:
>>
>>> On Fri, Nov 16, 2007 at 10:04:57PM +0100, Benoit Sigoure wrote:
>>>> On Nov 16, 2007, at 9:28 PM, Mike Hommey wrote:
>>>>>  test_expect_success \
>>>>>  	'message in editor has initial comment' '
>>>>>  	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
>>>>> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
>>>>> +	( read empty ;
>>>>> +	  [ "$empty" ] && exit 1 ;
>>>>
>>>> What is this meant to do?  Did you mean [ -n "$empty" ] ?
>>>
>>> Replacing with [ -n "$empty" ] would not work properly, except if  
>>> you
>>> replace the following ; with &&. Does that really make a readability
>>> difference ?
>>
>> I don't get it.  As far as I understand, you're trying to check  
>> whether
>> $empty is indeed empty, right?  So how is `[ "$empty" ]' meant to  
>> work?
>>   [ -n "$empty" ] && exit 1
>>
>> will exit 1 if empty isn't empty.
>
> Sorry, I read '-z', not '-n'. [ "$empty" ] and [ -n "$empty" ] are the
> same thing.

Heh, forgive my ignorance, I did not know the [ "string" ] notation.   
Amazing, after all these years of shell scripting...

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-51-46583865
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHPg/gwwE67wC8PUkRAri5AKCIs2Tc47VkbOTq4kod0CEDnUpT+wCgq9bq
04EVRpqpbp0lLcJTOUa4PBo=
=o+j8
-----END PGP SIGNATURE-----

--Apple-Mail-51-46583865--
