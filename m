From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Diffs for submodule conflicts during rebase usually empty
Date: Sat, 13 Sep 2014 13:07:35 +0200
Message-ID: <54142577.3080104@web.de>
References: <20140911135057.o7j9bwlnz4okgwsw@webmail.mit.edu> <5411F818.6030701@web.de> <1410526589-sup-2306@sabre>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Edward Z. Yang" <ezyang@mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 13 13:07:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSlBO-0006Wr-D7
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 13:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbaIMLHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 07:07:46 -0400
Received: from mout.web.de ([212.227.15.3]:59636 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaIMLHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 07:07:45 -0400
Received: from [192.168.178.41] ([79.193.66.205]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MDxFv-1XZ4YS06D1-00HLqS; Sat, 13 Sep 2014 13:07:43
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <1410526589-sup-2306@sabre>
X-Provags-ID: V03:K0:Lkhdy/bU0WIY1kJorjGbnwM7IhW43QJSKe1HaD7uuqgMRqer6WX
 cSILBlZvkdOZ/374dDXgT1kl6nAnx9JK3i+sqKCqdNoJu5EZuqLR1bGwfwHZAtRek71vzYE
 rFgk0vDPiMM7S/lVGjhrlmk/ELEU36ISY7u1ba1joeJxIDKFXFr2UwNSZqBEVr2s7ry1lXD
 bcGJ9s8UyQ8J+3mzBxxsw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256962>

Am 12.09.2014 um 15:03 schrieb Edward Z. Yang:
> Hello Jens,
>
> Excerpts from Jens Lehmann's message of 2014-09-11 15:29:28 -0400:
>> Git does know what's going on, just fails to display it properly
>> in the diff, as the output of ls-files shows:
>>
>>      $git ls-files -u
>>      160000 6a6e215138b7f343fba67ba1b6ffc152019c6085 1    b
>>      160000 fc12d3455b120916ec508c3ccd04f23957c08ea5 2    b
>>      160000 33d9fa9f9e25de2a85f84993d8f6c752f84c769a 3    b
>
> Right. But I'd also add that even though Git knows what's going
> on, even if we reported /that/ it wouldn't be user friendly:
> namely, because submodules are not updated automatically so the
> first line would always be what the submodule was pointed to
> before we started rebasing.  That's not so useful either...
>
>> I agree that this needs to be improved, but am currently lacking
>> the time to do it myself. But I believe this will get important
>> rather soonish when we recursively update submodules too ...
>
> As I've said, I'm happy to contribute a patch, if we can agree
> what the right resolution is...

Me thinks the next step would be that "git diff --submodule"
should learn to not only show 2-way diffs but also 3-way diffs.
Then we'll be able to display submodule merge results in a human
readable way. After that we would have to find a way to display
submodule merge conflicts in a human readable way, similar to
what we do with conflict markers for regular files.
