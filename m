From: Ivan Ukhov <ivan.ukhov@gmail.com>
Subject: Re: [PATCH] parse-options: fix the description of defval
Date: Sun, 29 Mar 2015 15:45:56 +0200
Message-ID: <4999FA4A-6409-41F1-9791-F74114EB4BB8@gmail.com>
References: <E8C3474A-5A3A-4A51-A798-84FB9AD46A9F@gmail.com> <CACRoPnTjAu_pyPp2TXZGou=H8mkXBmQqgxGNusjW6u8peEfw6Q@mail.gmail.com> <0AC17F77-A324-40FA-9D5A-772C11E3BBDA@gmail.com> <CACRoPnQFBbhH0oKDON+nwHO_MiB_ZjiQQU1Wdsu7kVaqAEk=pA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2093\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 15:46:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcDXR-0002Af-22
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 15:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbbC2NqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 09:46:03 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34705 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141AbbC2Np7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2015 09:45:59 -0400
Received: by lboc7 with SMTP id c7so34150739lbo.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2015 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vJjhV48nadAtrZ5nGYWy1r2RsLxIeUydZkegQWpax7A=;
        b=Y/zCu7k3dDqDsvhvqaPGurdVngjQyWscaCH1WAnWSKEWgv2c2mNSCPETzpTHVOIaeF
         ovjvww/jj8LUUos6si2Poeh/kP7BNW2HpAWTDsv8pOjKhzw+v2/2ltVEvh5p1hk74OzO
         kl2If3b/oQ0nOEkCqouakJ4CMYTvdQGCcR0G8NLFI0wtfnKGGF4f+1lltcpg56S5FRh7
         KC2ZBSIm5kgDeePa4K3zsgprt0bfz1t3kyvl85pPCJCkPgyZS+jVO1FEIGFzdDPtj3Iw
         Z/pNDLowuXkeC5MPTluOF5z97WdYzimWtcAmCNQTDD6TLsOg47Van1zYtpt/2eiSHvrh
         gXXw==
X-Received: by 10.112.241.72 with SMTP id wg8mr25140157lbc.65.1427636757903;
        Sun, 29 Mar 2015 06:45:57 -0700 (PDT)
Received: from c-15c6e455.011-537-6c6b701.cust.bredbandsbolaget.se (c-15c6e455.011-537-6c6b701.cust.bredbandsbolaget.se. [85.228.198.21])
        by mx.google.com with ESMTPSA id v13sm1481092lal.4.2015.03.29.06.45.56
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Mar 2015 06:45:57 -0700 (PDT)
In-Reply-To: <CACRoPnQFBbhH0oKDON+nwHO_MiB_ZjiQQU1Wdsu7kVaqAEk=pA@mail.gmail.com>
X-Mailer: Apple Mail (2.2093)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266436>

Hello Paul,


Yes, you are right. Thank you for the clarification!


Regards,
Ivan

> On Mar 29, 2015, at 3:27 PM, Paul Tan <pyokagan@gmail.com> wrote:
> 
> Hi,
> 
> On Sun, Mar 29, 2015 at 5:28 PM, Ivan Ukhov <ivan.ukhov@gmail.com> wrote:
>> I have checked the definitions of the three macros you mentioned, and it seems that none of them uses defval to store pointers. OPTION_CMDMODE stores chars and integers. OPTION_STRING does not use defval at all (pointers go in a different field of the option struct), and the same applies to OPTION_FILENAME. I am probably missing something; can you please clarify what you mean? Thank you.
> 
> For OPTION_STRING, if the PARSE_OPT_OPTARG flag is set (as the
> documentation already states), the option can be provided on the
> command line without any corresponding argument. If provided as so,
> the string pointer of defval is used.
> 
> See get_value() in parse-options.c
> 
> I haven't used the other option types before yet (just did a grep
> 'defval' in parse-options.c) so I don't know what they do with defval.
> That's why it would be nice if they were documented :-)
> 
> Regards,
> Paul
