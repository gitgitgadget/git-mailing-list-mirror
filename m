From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Sat, 01 Mar 2014 23:33:53 +0100
Message-ID: <53126051.7030904@alum.mit.edu>
References: <CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com> <1393680567-2166-1-git-send-email-faiz.off93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunheehnus@gmail.com, sunshine@sunshineco.com
To: Faiz Kothari <faiz.off93@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 23:34:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJsUI-0004op-Hu
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 23:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbaCAWd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 17:33:58 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53794 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753285AbaCAWd5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Mar 2014 17:33:57 -0500
X-AuditID: 1207440f-f79326d000003c9f-6a-5312605457ed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id EE.8C.15519.45062135; Sat,  1 Mar 2014 17:33:56 -0500 (EST)
Received: from [192.168.69.148] (p57A25682.dip0.t-ipconnect.de [87.162.86.130])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s21MXsfq018116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 1 Mar 2014 17:33:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1393680567-2166-1-git-send-email-faiz.off93@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqBuSIBRs0H1C3eL+xlcsFl1Xupks
	2m5vZ7Q486aR0YHFY+esu+weix94eXzeJBfAHMVtk5RYUhacmZ6nb5fAndH+pp+54ANPxaP3
	S9kaGGdxdTFyckgImEhs7lvJCGGLSVy4t56ti5GLQ0jgMqPEsXPnoZxzTBLX77xkB6niFdCW
	OPP0OVgHi4CqxIlPJ5lAbDYBXYlFPc1gtqhAsMTqyw9YIOoFJU7OfAJmiwioS8z58QbMZhZw
	k/i25S4biC0sYCax/MtKdohlHYwSfdtOMYMkOAVcJCb/XsTaxcgBdJ64RE9jEESvjsS7vgfM
	ELa8xPa3c5gnMArOQrJuFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzR
	S00p3cQICW/+HYxd62UOMQpwMCrx8O6IEgoWYk0sK67MPcQoycGkJMpb5QsU4kvKT6nMSCzO
	iC8qzUktPsQowcGsJMJ7ngUox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh
	4FCS4P0ZB9QoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rh+GJgFIOkeID2vgFp
	5y0uSMwFikK0nmLU5bjd9usToxBLXn5eqpQ472mQIgGQoozSPLgVsGT2ilEc6GNhXrZ4oCoe
	YCKEm/QKaAkT0JKW/QIgS0oSEVJSDYxNmVun6SRZ6WbMsedaHXhxKo+uz8Yrb4KXxsSU/Xs5
	Y+GTvIy/lvlXVv3sX7sy59adMr3jlt17v3RceWqo/pLLK+HyhKPLm6/Wzq+ssV0w 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243112>

Please leave a little more time for people to give feedback between
versions of a patch series (unless the first version was so broken that
it would be pointless for any other reviewer to waste time on it.  And
please label the versions of a single patch series "[PATCH]" then
"[PATCH v2]", "[PATCH v3]", etc.

I agree with Johannes's advice that the function is in the wrong place
and has the wrong parameter order.

On 03/01/2014 02:29 PM, Faiz Kothari wrote:
> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
> ---
>>> -               write_or_die(1, rpc.result.buf, rpc.result.len);
>>> +               strbuf_write_or_die(1, &(rpc.result.buf));
> 
>> May be this should be
>> strbuf_write_or_die(1, &(rpc.result));
> 
> Yes, I changed that :-) Thanks again.

I find it alarming that either the compiler didn't emit warnings for the
old version or that you ignored the compiler warnings.  Git should
compile without warnings even with with quite strict compiler settings;
I use gcc with the following options

    -Wall -Werror \
        -Wdeclaration-after-statement \
        -Wno-format-zero-length \
        -Wno-format-security

Maybe you weren't including the header file that declares
strbuf_write_or_die() in the file containing this invocation?

Also, the parentheses in "&(rpc.result)" are unnecessary.

And I think that some of the blank lines that you added contained
invisible whitespace.  Please check your whitespace!  You can run "git
diff --check" to detect some obvious whitespace problems.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
