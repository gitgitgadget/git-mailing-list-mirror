From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Fwd: possible Improving diff algoritm
Date: Thu, 13 Dec 2012 01:00:08 +0100
Message-ID: <50C91A88.1090306@alum.mit.edu>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com> <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com> <7vvcc73yzh.fsf@alter.siamese.dyndns.org> <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com> <7vpq2f2az4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Morten Welinder <mwelinder@gmail.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 01:00:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiwE4-00054y-HO
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 01:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990Ab2LMAAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 19:00:13 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:60917 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754815Ab2LMAAM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2012 19:00:12 -0500
X-AuditID: 12074413-b7f786d0000008bb-e7-50c91a8b9469
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 88.FB.02235.B8A19C05; Wed, 12 Dec 2012 19:00:11 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qBD009I2014224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Dec 2012 19:00:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vpq2f2az4.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqNstdTLAYOoNZYuuK91MFg29V5gt
	7rc8YLKYPmspswOLx85Zd9k9ft19yeZx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGZ13tzEV
	TBOrWL/oDnsD4yG+LkYODgkBE4nDPxS7GDmBTDGJC/fWs3UxcnEICVxmlNi+YBs7hHOcSWJl
	0wo2kCpeAW2JL7f/sIPYLAKqEmsedoLZbAK6Eot6mplAbFGBAInFS86xQ9QLSpyc+YQFxBYR
	UJOY2HaIBWQxs0CqxKTGQJCwsICRxLUfkxkhdq1jkrh7vBOsnlPATOLEkllgNrOAjsS7vgfM
	ELa8xPa3c5gnMArMQrJiFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdfLzSzR
	S00p3cQICWfhHYy7TsodYhTgYFTi4W06fyJAiDWxrLgy9xCjJAeTkijvUomTAUJ8SfkplRmJ
	xRnxRaU5qcWHGCU4mJVEeNv/A5XzpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFk
	ZTg4lCR4+YFxKyRYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitT4YmCsgqR4gPZ+
	lARq5y0uSMwFikK0nmLU5diwvv0JoxBLXn5eqpQ4ryjI4QIgRRmleXArYMnrFaM40MfCvK9B
	RvEAEx/cpFdAS5iAlsRdOg6ypCQRISXVwMi+1HaLg1PLpH8sh5/L8v17w8eotHjR3u+mGjKP
	hDct3LJZTc3OR//tb6Mv+1NrlHWtPTxnyd9bNflm9YEOX876b5nbZHYnlPRW/PNu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211424>

On 12/12/2012 10:53 PM, Junio C Hamano wrote:
> Morten Welinder <mwelinder@gmail.com> writes:
> 
>> Is there a reason why picking among the choices in a sliding window
>> must be contents neutral?
> 
> Sorry, you might be getting at something interesting but I do not
> understand the question.  I have no idea what you mean by "contents
> neutral".
> 
> Picking between these two choices
> 
>          /**                         +    /**                         
>     +     * Default parent           +     * Default parent           
>     +     *                          +     *                          
>     +     * @var int                 +     * @var int                 
>     +     * @access protected        +     * @access protected        
>     +     * @index                   +     * @index                   
>     +     */                         +     */                         
>     +    protected $defaultParent;   +    protected $defaultParent;   
>     +                                +                                
>     +    /**                              /**                         
> 
> would not affect the correctness of the patch.  You may pick
> whatever you deem the most desirable, but your answer must be a
> correct patch (the definition of "correct" here is "applying that
> patch to the preimage produces the intended postimage").
> 
> And I think if you inserted a block of text B after a context C
> where the tail of B matches the tail of C like the above, you can
> shift what you treat as "inserted" up and still come up with a
> correct patch.

I have the feeling that a few crude heuristics would go a long way
towards improving diffs like this.  For example:

* Prefer to have an add/remove block that has balanced begin/end pairs
(where begin/end pairs might be opening and closing parentheses,
brackets, braces, and angle brackets, "/*" and "*/", and perhaps a
couple of other things.  For SGML-like text begin and end tags could be
matched up.

It would be possible to read these begin/end pairs from a
filetype-specific table or configuration setting, though this would add
complication and would also make it possible that diffs generated by two
different people are not identical if their configurations differ.

* Prefer to have a block where the first non-blank line of the block and
the first non-blank line after the block are indented by the same amount.

* Prefer to have a block with trailing (as opposed to leading or
embedded) blank lines--the more the better.

The beautiful thing is that even if the heuristics sometimes fail, the
correctness of the patch (in the sense that you have defined) is not
compromised.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
