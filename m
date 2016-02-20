From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Sat, 20 Feb 2016 20:13:40 +0530
Message-ID: <CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
	<vpq37so26oz.fsf@anie.imag.fr>
	<CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
	<CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 15:43:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX8lC-0004BD-8P
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 15:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758698AbcBTOnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 09:43:43 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36402 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbcBTOnl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 09:43:41 -0500
Received: by mail-qg0-f54.google.com with SMTP id y9so83922348qgd.3
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 06:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i18E38GIjVzi8e4A9FnNk7F2jnHypHA9uqWFun/wefg=;
        b=aZcmtpwrKp8cmI/DI4VTsTGodDr2wGN5sb4X8TprzBXI7QQOzXtUY4+g2ki3SH6qmS
         KdhTAN9LwsTWEFqIO2LV89CCOvv1/28pzeZhn7AUiV6r7IjRCxNHA6+LzKcGFNT0A5L5
         iHnXSK5MFZ+L6MNpLl7RVuu7cGbd/HCor4GuRc+b+x+gDkRjNXFkO3CSIHYDjbiJotMJ
         oOtJUF5hsYZWs5cqDKQrhIuX/1smsC1ByeazCA4YNfeQ+x5nymilav2B+7YufbFhPToY
         D0fIgUj3gJFQclcB4T6FJf5haEdH3Y2/XY6AR7FMPpOehZNe1W2mzPNekZe0sK2ExRfa
         IuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=i18E38GIjVzi8e4A9FnNk7F2jnHypHA9uqWFun/wefg=;
        b=fsdwlrUnOrU+feuvxUhRi/OAKaV/6nB0vKtbDdEXdR59WCwB7iLc/P75q03FU8RTOJ
         o2LE2Tc56x2M0VErewnU+rR/XuBLEGzsDekqvu2lcM1haBUbhBS3CrkK5mrVOr5iDXN+
         vdZlv1WBbpPrVOXXWdYtcyQISa5vdSM1a6rckTJpWTAAilzUaNJUxescsbuFytFSAt6Q
         As42sIPxdqAVdyegMVpIyj/b2Fz0PcUW4DiLV5N42pO4GqoNdGnMC6n9m2btZ4V5k/Co
         UfnKQD8Es/6Vx6pLdMm/BRZ9HPCGEd9L8bdKPLPwUwK1F54tto96CTjbNVApwp2yqkNB
         LZFg==
X-Gm-Message-State: AG10YOTF/DxjBgC46T+PLJtXO+ACkgH75kz8/0i3t4Fr4ZAsYkSYdiYcT1VRmGefyibFOj/T8FKS1pKN1ux0DA==
X-Received: by 10.140.157.7 with SMTP id d7mr24680387qhd.17.1455979420943;
 Sat, 20 Feb 2016 06:43:40 -0800 (PST)
Received: by 10.55.154.205 with HTTP; Sat, 20 Feb 2016 06:43:40 -0800 (PST)
In-Reply-To: <CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286783>

Hello,

I faced the following problem when I tested master branch. Here I have
made no commits to master branch.

*** t5539-fetch-http-shallow.sh ***
ok 1 - setup shallow clone
not ok 2 - clone http repository
#
# git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
# git clone $HTTPD_URL/smart/repo.git clone &&
# (
# cd clone &&
# git fsck &&
# git log --format=%s origin/master >actual &&
# cat <<EOF >expect &&
# 7
# 6
# 5
# 4
# 3
# EOF
# test_cmp expect actual
# )
#
not ok 3 - no shallow lines after receiving ACK ready
#
# (
# cd shallow &&
# test_tick &&
# for i in $(test_seq 15)
# do
# git checkout --orphan unrelated$i &&
# test_commit unrelated$i &&
# git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
# refs/heads/unrelated$i:refs/heads/unrelated$i &&
# git push -q ../clone/.git \
# refs/heads/unrelated$i:refs/heads/unrelated$i ||
# exit 1
# done &&
# git checkout master &&
# test_commit new &&
# git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
# ) &&
# (
# cd clone &&
# git checkout --orphan newnew &&
# test_commit new-too &&
# GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" git fetch --depth=2 &&
# grep "fetch-pack< ACK .* ready" ../trace &&
# ! grep "fetch-pack> done" ../trace
# )
#
# failed 2 among 3 test(s)
1..3
make[1]: *** [t5539-fetch-http-shallow.sh] Error 1
make[1]: Leaving directory `/home/mj/git/t'
make: *** [test] Error 2

Is this test failure usual with linux based system or just happened with me.
I'm running Ubuntu 14.04.

thanks,
Mehul Jain

On Fri, Feb 19, 2016 at 11:20 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Feb 19, 2016 at 9:39 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
>> On Fri, Feb 19, 2016 at 6:33 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Hi,
>>>
>>> This is a double-post. You've posted almost the same message under the
>>> title "GSoC 2016". Nothing serious, but attention to details is
>>> important if you want to give a good image of yourself.
>>
>> I'm sorry of this kind of behavior. It was due to a misunderstanding by my side.
>>
>>> I don't have all the code in mind, but I think it is. In this situation,
>>> you always end up with a variable telling Git what to do (I guess,
>>> autostash here), and this variable is set according to the configuration
>>> and the command-line.
>>>
>>> You should be careful about the precedence: command-line should override
>>> the configuration. And the default behavior should be used if neither
>>> the command-line nor the configuration specified otherwise.
>>
>> Thanks for the suggestion.
>> I've started the work on patch and did the change in the code which
>> were necessary for Microproject. I have run the test by using "make",
>> and there was no failure of any test.
>> I've a doubt regarding tests. Here as "git pull" will now understand
>> the argument that  "--[no-]autostash" means "rebase.autostash" should
>> be set false for current execution of command "git pull --rebase". So
>> do I have to write a test for this new option?
>>
>
> Yes, most likely t/t5521-pull-options.sh or t/t5520-pull.sh would be the right
> place as judging from the file name of the tests.
>
> Thanks,
> Stefan
>
>> Mehul Jain
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
