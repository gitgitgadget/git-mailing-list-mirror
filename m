Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69DFE1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 17:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeH2Vkc (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 17:40:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:37899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbeH2Vkc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 17:40:32 -0400
Received: from [10.24.110.212] ([185.190.160.130]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWxtA-1gOirg38Ym-00W1ai; Wed, 29
 Aug 2018 19:42:28 +0200
Subject: Re: [PATCH v3] doc: Don't echo sed command for manpage-base-url.xsl
To:     Jonathan Nieder <jrnieder@gmail.com>
References: <20180829134334.14619-1-timschumi@gmx.de>
 <20180829154720.20297-1-timschumi@gmx.de>
 <20180829165540.GB170940@aiede.svl.corp.google.com>
From:   Tim Schumacher <timschumi@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <c38b994b-b77d-fe03-42f9-9e22ac92e98d@gmx.de>
Date:   Wed, 29 Aug 2018 19:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180829165540.GB170940@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rtvOCobY5Ilowrd9BTs+INeXQUSdG+b6s5dGQHIKW7NOky0jj7x
 NGJubac2D0O85hTiWmBfrHt6v7G8OSA34PdhULst+ayN0q2FCctNKI5uocscCghvhYSduAo
 2ObFX0fW9BS9jCTmk0p+UQOVEAuIqK/0rqkO10bsKGvS2m957+FeS1Cj59WhWFfo2K9RnTj
 Hkvf7EQbmhkfxfGjXnFzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RBA27g8bD3M=:nD1gyt0tAGy8b9DMr1xW2j
 35DJC7gfgz0lXdlK30mVP78LX5YFEoAxPIQ92I0d7hHF5vLTAQK7WZSAagivdTOqaU8NjeLa3
 n61gnsuBm99S3so/psOEqdbo6xfp2XiXlvTiN3qewG5FCmi6c2e6FzwVsYFFelkiJMCxWNV4t
 sait19l/QcKXGB1hZz6NMrUiRlg+WT0H+MVqRZyT5t09W1jSCVrsKoFQExCAzzbDcNoyY2W3v
 hYJ/Vq2v7DThAv2gXyUrqsxK07A8aq6OAWtLv0nvNHzT8S0PYOYmkwx0PeMjQ/60a9WyUyhU3
 zOHdeUzLnN4K+0NYgcarMvtuyPJua6tmy6ovRg0QGS7OXTlyIl/fpbjSolFN0NCCSOfZLf0cz
 8+aaKgUa7fiAS7LsOWOtwfkOvDckLYPn7dz1hIEurCaR1wyQgyyAb63ZRDZO9HZg9WYYnudo5
 EHkBkDQWCdzeD0Um0qH69n3XfUEPyUi83R9yw+405Zr8n2dFV9SZ/CKn4LzVe8y/tMqvoxXh5
 upxhJ3rgy6OtY0WGPQMyJKB3KV+cuXCGfhQYj/OHdfs4XitMrNxRXbnVQa7zPSlFO7/DM3Tqm
 oM4l3c3b1C6uvQgly2PNgCxvTUuS9BTvT+4POUhQmPyjXLW+HKQGSpzyyIs//5laGJvZ27oUE
 JASnYccLtfWSqrN/vh9MLvqUcqtWAd2Yu5d4oIi20p8q0HjlG4kK7+ofQcVVn1V0BFmWZzAg2
 7fgkTLnMYvbnI52+BsGSnQxGtHZzsJJCsPuT6oV7HSAWbYlAXimct5a2bltNUk18MXRkeXaQk
 SnwOYbpOWbWLhVuSk8GdMmxBgPXVVmIueBXSM6Ix8K29lp2qqmViI267VlbUP+rpjoqYK145j
 vBeDb1nhS8j81fHZSzuXEel4vN06WQKlsA+wOECPc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.08.18 18:55, Jonathan Nieder wrote:
> Tim Schumacher wrote:
> 
>> Subject: doc: Don't echo sed command for manpage-base-url.xsl
> 
> Cribbing from my review of v2: a description like
> 
> 	Documentation/Makefile: make manpage-base-url.xsl generation quieter
> 
> would make it more obvious what this does when viewed in "git log
> --oneline".

imho, the "Documentation/Makefile" is a bit too long (about 1/3 of the
first line). Would it be advisable to keep the previous prefix of "doc"
(which would shorten down the line from 68 characters down to 49) and
to use only the second part of your proposed first line? Depending on
the response I would address this in v4 of this patch.

> 
>> Previously, the sed command for generating manpage-base-url.xsl
>> was printed to the console when being run.
>>
>> Make the console output for this rule similiar to all the
>> other rules by printing a short status message instead of
>> the whole command.
>>
>> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
>> ---
>>   Documentation/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Oh!  Ignore my reply to v2; looks like you anticipated what I was
> going to suggest already.  For next time, if you include a note about
> what changed between versions after the --- delimiter, that can help
> save some time.
> 

The change to QUIET_GEN was proposed by Junio, but that E-Mail
wasn't CC'ed to the mailing list, probably due to him typing
the response on a phone.

I originally included a note about the change as well, but I
forgot to copy it over to the new patch after I generated a
second version of v3.

> With or without the suggested commit message tweak,
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thank you.
> 

Thanks for the review!
