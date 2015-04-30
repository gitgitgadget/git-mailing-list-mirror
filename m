From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 10:12:04 +0200
Message-ID: <5541E3D4.7040207@alum.mit.edu>
References: <1430341032.14907.9.camel@ubuntu>	<xmqqlhha4otr.fsf@gitster.dls.corp.google.com>	<1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>	<1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>	<20150430003750.GA4258@peff.net> <1430355983.14907.55.camel@ubuntu>	<20150430011612.GA7530@peff.net> <1430358345.14907.62.camel@ubuntu>	<20150430033725.GB12361@peff.net> <xmqqfv7i2n81.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 10:12:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynja1-00088l-8a
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 10:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbbD3IMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 04:12:10 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:47459 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751345AbbD3IMH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2015 04:12:07 -0400
X-AuditID: 12074413-f79f26d0000030e7-b3-5541e3d6839c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id D5.4E.12519.6D3E1455; Thu, 30 Apr 2015 04:12:06 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97A01.dip0.t-ipconnect.de [79.201.122.1])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3U8C44n026659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 30 Apr 2015 04:12:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqfv7i2n81.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqHvtsWOowc9fshbzN51gtOi60s1k
	0dB7hdniR0sPswOLx7PePYweFy8peyx4fp/d4/MmuQCWKG6bpMSSsuDM9Dx9uwTujE/z3Qo+
	s1ac3irWwHiOpYuRk0NCwETi174jzBC2mMSFe+vZuhi5OIQELjNKXOs8zQrhnGOSuLrjICNI
	Fa+AtkRP021WEJtFQFWi4exRsG42AV2JRT3NTCC2qECQROu1qVD1ghInZz4B2yYi4Chx4sF1
	sF5mgRiJdVOXgfUKCxhKfDlwlxli2V5miU/br7OBJDgFrCU2zPnEBNGgJ7Hj+i+oZnmJ5q2z
	mScwCsxCsmMWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJ
	Z+EdjLtOyh1iFOBgVOLhndHqGCrEmlhWXJl7iFGSg0lJlDf9IVCILyk/pTIjsTgjvqg0J7X4
	EKMEB7OSCO/hR0A53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEbzVI
	o2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoUuOLgbEKkuIB2jsbbG9xQWIuUBSi
	9RSjLsedKf8XMQmx5OXnpUqJ88aDFAmAFGWU5sGtgCWvV4ziQB8L854EqeIBJj64Sa+AljAB
	LTl/ywFkSUkiQkqqgXHd+qk1fydd/98xX5r55bxSAcfulBnLp100idbZqvKC7X583+RNx7p4
	zSTD3F//YfQXe6FXbB2W/IdrrjvTroxZomu1DgannguezhrT8KEy+UChWlUUo4yI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268063>

On 04/30/2015 07:34 AM, Junio C Hamano wrote:
> [...]
> But stepping back a bit.
> 
> We have been talking about HEAD^{resolve}:fleem but how did we learn
> that there is a path "fleem" in the tree of HEAD in the first place?
> I would presume that the answer eventually boils down to "somebody
> fed HEAD to 'ls-tree -r'", and then that somebody is an idiot if it
> did not grab the mode bits to learn what kind of blob fleem is, or
> if it did not tell the guy that wants to drive "cat-file --batch".

I think a plausible use case for this feature is to read
`$tag^{resolve}:RelNotes`, in which case the reason we know it's there
is "because the maintainer told us it is there".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
