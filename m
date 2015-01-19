From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] test: add git apply whitespace expansion tests
Date: Sun, 18 Jan 2015 19:54:45 -0800
Message-ID: <AB9246EB-D720-4A4A-9AB7-4307613C19A3@gmail.com>
References: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com> <CAO2U3Qjn9o_eYayEMCC3S6DBr9kVH7mPL00QGrXAnV2iYRP-=A@mail.gmail.com> <CAO2U3Qj-Hg2tb72NgO6wb-aqAxFG7aga2ZDeZNDCPJzGtmHTAA@mail.gmail.com> <CAO2U3Qhd_DPP09BUyMr6NKUtOe4EQQ7G83BRg7MbtQXFPjKv8w@mail.gmail.com> <CAO2U3Qje-YwcV1d5BK_zZqrTki4AU=emdkUZzEEieRjmoQdmGg@mail.gmail.com> <CAO2U3Qi4TWZiNoOQVSW=Ycvp3bpBySZrCGmRLCbRJJes_n2Wkw@mail.gmail.com> <99579252-EF8A-4DAF-A49D-2AC5627ED9E3@gmail.com> <4157F6B0-DDF4-4F71-A09B-EE216537CA89@gmail.com> <xmqqbnly1oqo.fsf@gitster.dls.corp.google.com> <xmqqzj9iz3gu.fsf_-_@gitster.dls.corp.google.com> <102e322e68e78e39a7c227f3f3e102c@74d39fa044aa309eaea14b9f57fe79c> <CAPc5daXVk_ROUy7rmzS0aosWvE2wqw8tHZgomHHkay9CZjhbiw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Blume <blume.mike@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 04:54:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YD3QU-0007rh-VU
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 04:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbbASDyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 22:54:50 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:62838 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbbASDyt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2015 22:54:49 -0500
Received: by mail-pd0-f178.google.com with SMTP id r10so33894892pdi.9
        for <git@vger.kernel.org>; Sun, 18 Jan 2015 19:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=hJtgRP3jl1dLX3ovIHTNux3coEOYNTceP591JTG2QjQ=;
        b=tTUY9NX3mBJf+1bp/pgbn2N0Yk3hPrtmgowMilWHLjxWFqIHJocYrG8UWCEoFPSzr/
         /xloqkxidJNHB0dApuyuttopkEvDJ0cTDekqVrS43xWEY2aNUmOS7K6J6Il5NTyksbiQ
         aGYRTPxU3pf7pwYs77bSZwNauTPTMKia4AXrH2+saXCBM6pm7W4WBWpfSjf0tpkmQPmU
         DJrET7PGH8G7Sj/dEJRcbYQXNcPSyWL287iwx3HACgb9J+akSJSpwiEDPBsgBEO8vcoD
         tA7TFZWKCcHUxCEpOSrBWQY6sXIPjpCM8xXujjhhFesu/5xzibPpVmZXRq4YR2sp7+F+
         FU0A==
X-Received: by 10.70.92.200 with SMTP id co8mr40184945pdb.101.1421639688615;
        Sun, 18 Jan 2015 19:54:48 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id mw3sm10185918pdb.70.2015.01.18.19.54.47
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 18 Jan 2015 19:54:48 -0800 (PST)
In-Reply-To: <CAPc5daXVk_ROUy7rmzS0aosWvE2wqw8tHZgomHHkay9CZjhbiw@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262610>

On Jan 18, 2015, at 14:11, Junio C Hamano wrote:

> On Sun, Jan 18, 2015 at 2:49 AM, Kyle J. McKay <mackyle@gmail.com>  
> wrote:
>> * Here's some tests.  With "apply: make update_pre_post_images()  
>> sanity
>>  check the given postlen" but not "apply: count the size of postimage
>>  correctly" test 1/4 and 4/4 trigger the 'die("BUG: postlen...' but
>>  test 2/4 and 3/4 do not although they fail because git apply  
>> generates
>>  garbage.
>
> Do the failing cases that do not trigger the new postlen check fail
> because the original (mis)counting thinks (incorrectly) that the
> rewritten result _should_ fit within the original postlen (hence we
> allow an in-place rewrite by passing postlen=0 to the helper), but
> in fact after rewriting postimage->len ends up being longer due to
> the miscounting?

I'm not 100%, but I think so because:

Before 250b3c6c (apply --whitespace=fix: avoid running over the  
postimage buffer, 2013-03-22), tests 1 and 4 tend to easily cause seg  
faults whereas 2 and 3 just give garbage.

After 250b3c6c (apply --whitespace=fix: avoid running over the  
postimage buffer, 2013-03-22), tests 1 and 4 may pass without seg  
faulting although clearly there's some memory corruption going on  
because after "apply: make update_pre_post_images() sanity check the  
given postlen" they always die with the BUG message.

I created the tests after reading your description in "apply: count  
the size of postimage correctly".  I made a guess about what would  
trigger the problem -- I do not have a deep understanding of the  
builtin/apply.c code though.  Tests 2 and 3 were attempts to make the  
discrepancy between counted and needed (assuming the "apply: count the  
size of postimage correctly" fix has not been applied) progressively  
worse and instead I ended up with a different kind of failure.  Test 4  
was then an alternate attempt to create a very large discrepancy and  
it ended up with BUG: values not that dissimilar from test 1.

FYI, without the counting fix, test 1 causes "BUG: postlen = 390, used  
= 585" and test 4 causes "BUG: postlen = 396, used = 591".  So while I  
did manage to increase the discrepancy a bit from the values you  
reported for clojure (postlen = 262, used = 273), I was actually  
aiming for a difference big enough to pretty much always guarantee a  
core dump.

The garbage tests 2 and 3 produce without the counting fix is  
reminiscent of what you get when you use memcpy instead of memmove for  
an overlapping memory copy operation.

A slightly modified version of these 4 tests can be run as far back a  
v1.7.4 (when apply --whitespace=fix started fixing tab-in-indent  
errors) and you get core dumps or garbage there too for all 4.

So since I've not been able to get test 2 or 3 to core dump (even  
before 250b3c6c) I tend to believe you are correct in that the code  
thinks (incorrectly) that the result should fit within the buffer.  I  
say buffer because the test 3 patch inserts 100 lines into a 6 line  
file and yet it never seems to cause a core dump (even in v1.7.4), so  
the buffer size must be based on the patch, not the original -- I'm  
sure that would make sense if I understood what's going on in the  
apply code.

I did manage to create a test 5 that causes "BUG: postlen = 3036, used  
= 3542", but its verbose output has unfriendly long lines and it's  
fixed by the same counting fix as the others so it doesn't seem  
worthwhile to include it.

-Kyle
