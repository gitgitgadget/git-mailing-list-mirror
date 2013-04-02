From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] rev-parse: clarify documentation for the --verify option
Date: Tue, 02 Apr 2013 18:28:20 +0200
Message-ID: <515B0724.3060702@alum.mit.edu>
References: <1364625865-8459-1-git-send-email-mhagger@alum.mit.edu> <7vwqsnnpwj.fsf@alter.siamese.dyndns.org> <7vli92jijz.fsf@alter.siamese.dyndns.org> <515A8D79.6050808@alum.mit.edu> <7vobdxgeud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:29:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN44w-00016u-Ji
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761686Ab3DBQ21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:28:27 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:62794 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759653Ab3DBQ2X (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 12:28:23 -0400
X-AuditID: 12074411-b7f286d0000008e8-09-515b0726a3c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id CD.ED.02280.6270B515; Tue,  2 Apr 2013 12:28:22 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r32GSKT3020908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Apr 2013 12:28:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <7vobdxgeud.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqKvGHh1o0PzK2KLrSjeTRUPvFWYH
	Jo+Ll5Q9Pm+SC2CK4rZJSiwpC85Mz9O3S+DO+HXmCWvBb6GK7lnVDYy/+boYOTkkBEwk9v9/
	zw5hi0lcuLeerYuRi0NI4DKjxOxHB5ghnGNMEk/e3wCr4hXQltjw4DELiM0ioCrx4csnRhCb
	TUBXYlFPMxOILSoQJrH3wjQ2iHpBiZMzn4DViwioSUxsOwRkc3AwC4hL9P8DCwsL+ErcnX4Q
	rFVI4CGjxJtFwiA2p4CZxMTG+2A1zAI6Eu/6HjBD2PIS29/OYZ7AKDALyYZZSMpmISlbwMi8
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMkSAV3MM44KXeIUYCDUYmH98SX
	qEAh1sSy4srcQ4ySHExKorwqzNGBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR443YClfOmJFZW
	pRblw6SkOViUxHn5lqj7CQmkJ5akZqemFqQWwWRlODiUJHgb2YCGChalpqdWpGXmlCCkmTg4
	QYZzSYkUp+alpBYllpZkxIPiNL4YGKkgKR6gvVUg7bzFBYm5QFGI1lOMuhxdiz6/YhRiycvP
	S5US510LUiQAUpRRmge3ApaSXjGKA30szFsNUsUDTGdwk14BLWECWrLsVjjIkpJEhJRUA+PE
	KYw7GrqOML7zTzyUc+2y7cYdSj+SftWujd70auImr6j3kr+VQ35aVjIER9y40vz1bvoBqa+z
	i6cZcsVMWNdguLT6ua5goW3wlEW3886eeCh9aK1+f0xk4TNNvqOllxz4W+Ss7y95 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219790>

On 04/02/2013 04:57 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 04/01/2013 06:56 PM, Junio C Hamano wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Because the primary use case of this option is to implement end-user
>>>> input validation, I think it would be helpful to clarify use of the
>>>> peeler here.  Perhaps
>>>> ...
>>>
>>> A "SQUASH???" patch on top of your original is queued on 'pu',
>>> together with the earlier "^{object}" peeler patch.  Comments,
>>> improvements, etc. would be nice.
>>
>> Yes, your version is better.  I would make one change, though.  In your
>>
>> +	Make sure the single given parameter can be turned into a
>> +	raw 20-byte SHA-1 that can be used to access the object
>> +	database, and emit it to the standard output. If it can't,
>> +	error out.
>>
>> it could be made clearer that exactly one parameter should be provided.
>> Maybe
>>
>> +	Verify that exactly one parameter is provided, and that it
> 
> That is probably better (I was hoping "the single" would mean the
> same to the reader, though).  Thanks.
> 
>> +     can be turned into a raw 20-byte SHA-1 that can be used to
>> +	access the object database.  If so, emit the SHA-1 to the
>> +	standard output; otherwise, error out.
>>
>> But this makes it sound a little like the "raw 20-byte SHA-1" will be
>> output to stdout,...
> 
> I did consider that point, wrote "and outputs 40-hex" in my earlier
> draft, and then rejected it because it was even more misleading.
> The output follows the usual rules for "rev" parameters, e.g.
> 
> 	git rev-parse --short --verify HEAD
> 	git rev-parse --symbolic --verify v1.8.2^{tree}
> 
> and "--verify" does not mean 40-hex output.  That is why I left it
> vague as "emit it".
> 
> I agree that the wording incorrectly hints that you may be able to
> get 20-byte raw output.  I didn't find a satisfactory phrasing.

It's the explicit mention of "raw 20-byte" that puts the reader in mind
of 20-byte binary data.  I think any version that omitted that phrase
would let the reader make the assumption that the SHA-1s are expressed
as 40-byte hex numbers just they are everywhere else in the command-line
interface.

But I'm OK with any of the variations that we have discussed.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
