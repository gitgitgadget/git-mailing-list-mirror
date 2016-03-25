From: Dominik Fischer <d.f.fischer@web.de>
Subject: Re: [PATCH/GSoC] add a add.patch config variable
Date: Fri, 25 Mar 2016 01:43:47 +0100
Message-ID: <56F489C3.9050400@web.de>
References: <1458853787-29807-1-git-send-email-d.f.fischer@web.de>
 <1458853787-29807-2-git-send-email-d.f.fischer@web.de>
 <xmqqvb4b7eu9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 01:43:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajFr3-0001r3-O1
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 01:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbcCYAnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 20:43:53 -0400
Received: from mout.web.de ([212.227.17.11]:64945 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbcCYAnw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 20:43:52 -0400
Received: from [192.168.178.38] ([95.116.247.71]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Lcy1k-1a19bo2m80-00iBi2 for <git@vger.kernel.org>;
 Fri, 25 Mar 2016 01:43:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqvb4b7eu9.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:uNYxNhSSUBflEgaBXNvWYfpKz4WmfmYcW6hbrTJ7+ea/RGWmr6h
 QFR26Qp5i0OGGGHv0Hf8f0llTB5nzaWeOFmG2E7AnYS3VrkYivM3fzQso64g9TVfIHiVgtj
 N4TkxiSeHXRNT8vGs/9MUUiwZ+62+vkLexgEhxERbgc7AVElPvGC14MTkF9QQRWNNB0b7dc
 7WnwcZbj1TAwviTM/CrUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5nDkm7dREoc=:/UFmZt4RcLMXe701yogVdz
 As6TROkEUKodTAckVJYsQ29NWDQZfkdaZsSbWRjOQrfHjzWcUbG2JMrJB128ZA9LmJzbX8tly
 bWpmDG4VEWdSXrK0vyi0N8mCPNpW/yAgJkPbn+A/f6gjVKDF+6OqbpH+5Wd3eBlVYA1ZvOUxX
 wsJ51wiPCjb2mxMjmfyt6JRxzQImIOqwyoMZMhO2QVl3wtYd7HT6T/QtZBRWGvOLRoye/TKpG
 xmFs1c0obin1yGHnwmLMfC/6xeKYsVQIDX4FT86FVuZv43nWOzts/0QP6DXrMvlxcyrUrFAhb
 an7QYmqYcaI8tlQhz2sNVL5/oYV0dMwCviuKs4j2xRd01DlCn8DPQMRL5A9SqpEoO4/TnIwFs
 2kUkC251sDtc/VP9dMVkxlo5jIFG5KWdhy+QNRuKurntZYndoE+NLfgnW6bgF7k1EvHfTimOZ
 GHQD4pbRboL2kPq2B6R8uykOk8Jy6uBS47MwlFSwC12X3hvOTzWvrjtQJqrIzasj776PkIKH/
 +FCj1XbGy4fxq4z0pOeCyoNcIHbMxO9S3BZtLyze3ZLq+SJXEOMlV3axFIIAsTcHz/yo+R+sj
 daceks0Qk5xjVURVvIcEuKsHDV8xz/xZAxoDnNmBqKdy/44MjHxoid9OSjtV2FZIvkyIt7rVn
 9JlZE+Y4LxUZgB5RP1/Cg72BrEYZKLArgXzfJSDqByHa3+AAt5QpLtKJkIsEa2Cal0GK/mmPk
 wkqD5j0ncMCpkN0IYXnV8Ci7ejiAwU8FuqrjFX0Nfu0nFt+FNzdn7TI1RoxLZKC3sZS8XT4+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289838>

Am 24.03.2016 um 22:20 schrieb Junio C Hamano:
> XZS <d.f.fischer@web.de> writes:
>> Users may like to review their changes when staging by default. It is
>> also a convenient safety feature for beginners nudging them to have a
>> second look at their changes when composing a commit.
>>
>> To this end, the config variable allows to have git-add to always act
>> like -p was passed.
>
> Now with such a configuration in her ~/.gitconfig, how would she
> ever run the normal "git add", which perhaps is invoked by one of
> the scripts she regularly uses?  E.g. "git mergetool"?

As the configuration variable can be overwritten by a command line 
option, I am tempted to amend this by replacing all occurrences of "git 
add" in other scripts with "git add --no-patch" to ensure the expected 
behavior.

But this would introduce changes into a vast number of points in the 
code. Apart from that, I suspect other options may have the same reason 
not to be available as config variables. It would be much better if 
git-add could ignore the variable when called internally, only taking it 
into account when used as an entrypoint.

Is there already a mechanism in place to determine if git was called by 
git? If not, I could implement one through an environment variable that 
counts up on each git invocation, essentially providing a git recursion 
counter.
