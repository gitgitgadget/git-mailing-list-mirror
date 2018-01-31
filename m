Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595281F404
	for <e@80x24.org>; Wed, 31 Jan 2018 16:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeAaQyL (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 11:54:11 -0500
Received: from mout.perfora.net ([74.208.4.196]:64402 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752372AbeAaQyK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 11:54:10 -0500
Received: from [192.168.1.104] ([194.237.255.67]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MD7RC-1eWywn1euK-00GXLq
 for <git@vger.kernel.org>; Wed, 31 Jan 2018 17:54:09 +0100
Subject: Re: Location limits on development, staging and production
 environments
From:   H <agents@meddatainc.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <baf15388-adb4-ddce-889f-3e71b1574044@meddatainc.com>
 <CAGyf7-GeEaCFeY7q3=-7cN6aLaWUBwbNAMAbtfHw6ZXanAy3hw@mail.gmail.com>
 <e737ea6f-493f-f6e4-7491-ee9c19609ee2@meddatainc.com>
Message-ID: <259af179-cdf1-1f27-95e4-b94f7ca12085@meddatainc.com>
Date:   Wed, 31 Jan 2018 17:54:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <e737ea6f-493f-f6e4-7491-ee9c19609ee2@meddatainc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K0:GAyPDwOL/eU0havtfOTXUf6VpSDFwQAkpa6sD+AsD/lSW5iw+W7
 hj0dpbjycU6g03L0fN/FiGHgMrQsL5k+FsyxeRe3JUWoAeYGHoKEbj24n9bO1ekMtP4BvZ1
 KtEGqA6xyjOdXApcpriuEB1L9DWYaGAsDT7DRsZkL0auMVojg+fhVg8sKSoCOym/9PEroxn
 5uzkZn+pR+2jOrs9LEjlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9n8RgBSKu9E=:Stneo98xV7zWWwnZaBW03f
 01CM/HiBoZVzARzy1yCT9d3Yvji/2SdnFce2H643lJqFvFVop/toJKoFpaEmA+raSBJYu7Abd
 PH8lbIX4hC5BdgI6veiBs3S8SKfRf6fsBzUa6uZMJWhUoM1pREp5heufFAVctEBNw3ttEvIZw
 cwrO+q+JBZS+YfA1sZLynVDBB78h4cj6cqCj0YYb0KXdzmKmOl18/2qhK1/JU7QBzHI4XoI28
 1EFYljVN3pS5EWh4TDZBWdgfpZvSpePcwz5ezmk+gfOts2tP+VArM46Ha1bRadfvhRfS0jeYX
 5hQgwbryFzQBhTt4VamZjmp9lh59w57lbockoihMYTuirz1jsMTaG+oMpLs5j4fyOEyjD4PGf
 wNTN5sQRSiV60OaBB+MT9ucrYc3jd+87sRNMeaM7sWjvOzZag0xXyGrTVRW7407vOoqg2VlW3
 YGrCcCDZhslQYJUp0FAAhRp+J3KDEbhmPUjEZ63EUPaCv52oGW4i1SPlYCh3DUuhtFhVrecQx
 flByC98WoWthu+lfJtDUg6TQySUrfFVnxRmnvCWPP2BPe+371iYXlgOcpa0QmygiLRwWXYQcV
 T3aGCZQHcZsotLKW07eCRFvyjhXzenGXQ0jKcMCS+4+zMIaYkB7OzfdxUcU7yZKHaaxgGlzSQ
 eiYlYV9ilx2M3chsIRhvMzT0ysaRth2i7nQAfBdab5Kxhk7DcylOgQVckGznk0XEFP+ehp4VT
 LoN3GPH3vSUspzVQWsND9s2XZ1IqFNjaovim8Rqg89OZUXPafYXzQfsMX/8=
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/30/2018 03:48 PM, H wrote:
> On 01/29/2018 10:02 PM, Bryan Turner wrote:
>> On Mon, Jan 29, 2018 at 11:08 AM, H <agents@meddatainc.com> wrote:
>>> I am a newcomer to git looking to set up a web development environment where individual computers are used for development, the development.git, staging.git and production.git repositories are stored on an external server reachable by password-less ssh and the staging and production websites are on yet another server, also reachable by password-less ssh from the git-server (and the development machines).
>>>
>>> Locating the three git repositories on an external server works fine but I have not been able to have the staging and production deployment files on another server. I believe this is what is referred by GIT_WORK_TREE and based on what I found on the web I created a post-receive hook of staging.git with the two lines:
>>>
>>> #!/bin/sh
>>> GIT_WORK_TREE=user@1.2.3.4:/var/www/html/dev.whatever git checkout -f master
>>>
>>> I believe this should deploy the files from the development work tree.
>>>
>>> The above, however, fails. Should it work? I am running git 1.7.1 on CentOS 6.
>> No, I wouldn't expect that to work. GIT_WORK_TREE is not remote-aware
>> in that way. It's expected to be a normal-ish filesystem path.
>>
>> Based on your description, and the hook you've written, it seems like
>> your intention is for the source to automatically be fetched and
>> checked out on the staging environment after each push. (This is
>> dangerous, and likely _not_ what you actually want, but I'll get to
>> that in a moment.)
>>
>> One option would be to setup something like NFS, so the git-server can
>> mount the filesystems from the staging and production nodes.
>>
>> A different, likely better, option would be to have the post-receive
>> script on the git-server use straight ssh to trigger a checkout script
>> on the staging server, e.g.:
>> #!/bin/sh
>> ssh example@staging-server -C /opt/deploy-staging.sh
>>
>> Your deploy-staging script would then do something like:
>> #!/bin/sh
>> GIT_WORK_TREE=/var/www/html/dev.whatever git pull origin
>>
>> That said, though, having such a simple script is dangerous because
>> Git is fully capable of having receiving multiple pushes concurrently,
>> and they can all succeed as long as they're updating different
>> branches. Since your script isn't considering what branches were
>> changed by the push, it could end up triggering simultaneous git
>> processes on the staging server all attempting to deploy concurrently.
>>
>> The stdin for the post-receive hook receives details about which refs
>> were changed, and you'll likely want to update your script to parse
>> stdin and only try to deploy staging if a specific, relevant branch
>> (master in your example) has changed.
>>
>> Lastly, I'll note that using post-receive will make the pushing
>> (remote) user wait while the staging server is deployed. If that
>> process is likely to take very long, you might want to decouple the
>> two somehow.
>>
>> Hope this helps!
> I should perhaps also have mentioned that although I am the only developer, I may use different computers to develop on. IOW, there should not be any conflict due to code being pushed by multiple developers.
>
> Let's see if I understand this correctly:
>
> - Unless NFS is used, the git archive and the deployment of the website code in this case should reside on the same computer.
>
> - The combination of the checkout script and the deploy-staging script should work provided not multiple updates to the same branch are pushed at the same time.
>
> I will try this later today but any other hints or suggestions you may have would be greatly appreciated!
>
I modified post-receive in the hook directory of the staging git archive on server 1 as per your first example and created the deploy-staging.sh script on server 2 where the staging website resides in /var/www/html/dev.whatever (as well as the live website in /var/www/html/whatever. However, when trying out the deploy-staging.sh script, it fails with the error message "...not a git repository...". I do have git on server 2 but what else would I need to set up to run this successfully? Note that the git repository is on server 1 and I am deploying to server 2.

Thanks!

