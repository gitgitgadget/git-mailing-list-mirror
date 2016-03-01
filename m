From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] git-p4: map a P4 user to Git author name and email address
Date: Tue, 1 Mar 2016 11:57:12 +0100
Message-ID: <71F1F742-5641-443A-9110-DCAA3CE80C00@gmail.com>
References: <1456829396-38659-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Luke Diamand <luke@diamand.org>,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 11:57:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aahzW-0003dK-So
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 11:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbcCAK5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 05:57:18 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36412 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbcCAK5R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2016 05:57:17 -0500
Received: by mail-wm0-f47.google.com with SMTP id n186so30521935wmn.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 02:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=67nQxlkiW0KK5IwPn2Upjmiemm84HocdDNOvEslgRxk=;
        b=MVZaolgEWRIUW6DRA638NT5mNK6PE+LedMwlJFRbfW85zR/Bkj9izsh92x2a6BmGk0
         VEmzMWbCyA3kYWwn6TMwLVdGJjbCGXtfn79g4t0Vx9aQqpsfQfjgnVbCMrBCKfGPpc9Y
         vVkpTWmzRDr9YOo/IpKmELsA+5qIsJK30JUgqhEHNNu3h2aaodZQuWU6eJK7rrTeWTli
         kfpXuCBj9v3YQ3SouhZuBDfW/JcEJh70N5ZCBay7zhMY/gjm04V5OisTKNOwat4zKOA5
         K6A40lgltxjy5P4rZaImkyMlvtrEMiArNUdGr/51D85hwZ8K1bO9huifCiLEOekE39k5
         /5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=67nQxlkiW0KK5IwPn2Upjmiemm84HocdDNOvEslgRxk=;
        b=FJWuXWucte6TBdPmA+Ai2ozy5KzZhhWK9ux+gAuj5FY7qG0UdxoeziBKk/r2TrLWS/
         WzjIcqdRf7F0ooeOESvPl3jiPnltn4xdXXwckpgtRxiyJK29uhKa2Kpy6arKt5bFQj4k
         ak4tIctUMevHoSvPU02WRrXGAzpvIbvpXHHCZ4lQXjmQwykgOHGWMQ/5/4tVJrkfcBlg
         UX2ZdmpV9kLCf9/ZwFQ+gmODD5k5GTEIvD9+hH4GZFW3R1ewKNAU+xARHX1Jxmw5zs/G
         eNdwyyDjeQlSco9j7CHeJN1gOB0+g0BaR6xUWKNNqB/xr3zI/wNRldONKLEs+S6XNA4y
         jwxw==
X-Gm-Message-State: AD7BkJI6sh5wxPt+GG5ExdnnRpTDP6ZJG/7zDP98pVIVewAsgNUMbP86D/CgoMCAAvCI2Q==
X-Received: by 10.194.200.194 with SMTP id ju2mr11878612wjc.63.1456829836039;
        Tue, 01 Mar 2016 02:57:16 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB539F.dip0.t-ipconnect.de. [93.219.83.159])
        by smtp.gmail.com with ESMTPSA id x65sm20765840wmg.4.2016.03.01.02.57.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 02:57:15 -0800 (PST)
In-Reply-To: <1456829396-38659-1-git-send-email-larsxschneider@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288007>


On 01 Mar 2016, at 11:49, larsxschneider@gmail.com wrote:

> From: Lars Schneider <lars.schneider@autodesk.com>
oops ... this should be "larsxschneider@gmail.com"... sorry

- Lars

> 
> Map a P4 user to a specific name and email address in Git with the
> "git-p4.mapUser" config. The config value must be a string adhering
> to the format "p4user = First Lastname <email@address.com>".
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> 
> diff to v1:
> 
> * use '=' instead of '->' to mimic SVN user mapping format (thanks Eric)
> * fix ASCII doc formatting (thanks Eric)
> * fix broken && chain in test (thanks Eric)
> * use more innocuous names for test users (thanks Luke and Torsten)
> * make regex accept more blank characters
> 
> Cheers,
> Lars
> 
> 
> Documentation/git-p4.txt   | 11 +++++++++
> git-p4.py                  |  9 +++++++
> t/t9828-git-p4-map-user.sh | 61 ++++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 81 insertions(+)
> create mode 100755 t/t9828-git-p4-map-user.sh
> 
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 738cfde..9f077fd 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -553,6 +553,17 @@ git-p4.keepEmptyCommits::
> 	A changelist that contains only excluded files will be imported
> 	as an empty commit if this boolean option is set to true.
> 
> +git-p4.mapUser::
> +	Map a P4 user to a name and email address in Git. Use a string
> +	with the following format to create a mapping:
> ++
> +-------------
> +git config --add git-p4.mapUser "p4user = First Last <mail@address.com>"
> +-------------
> ++
> +A mapping will override any user information from P4. Mappings for
> +multiple P4 user can be defined.
> +
> Submit variables
> ~~~~~~~~~~~~~~~~
> git-p4.detectRenames::
> diff --git a/git-p4.py b/git-p4.py
> index c33dece..bac341d 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1160,6 +1160,15 @@ class P4UserMap:
>             self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
>             self.emails[output["Email"]] = output["User"]
> 
> +        mapUserConfigRegex = re.compile(r"^\s*(\S+)\s*=\s*(.+)\s*<(\S+)>\s*$", re.VERBOSE)
> +        for mapUserConfig in gitConfigList("git-p4.mapUser"):
> +            mapUser = mapUserConfigRegex.findall(mapUserConfig)
> +            if mapUser and len(mapUser[0]) == 3:
> +                user = mapUser[0][0]
> +                fullname = mapUser[0][1]
> +                email = mapUser[0][2]
> +                self.users[user] = fullname + " <" + email + ">"
> +                self.emails[email] = user
> 
>         s = ''
>         for (key, val) in self.users.items():
> diff --git a/t/t9828-git-p4-map-user.sh b/t/t9828-git-p4-map-user.sh
> new file mode 100755
> index 0000000..e20395c
> --- /dev/null
> +++ b/t/t9828-git-p4-map-user.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +
> +test_description='Clone repositories and map users'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'Create a repo with different users' '
> +	client_view "//depot/... //client/..." &&
> +	(
> +		cd "$cli" &&
> +
> +		>author.txt &&
> +		p4 add author.txt &&
> +		p4 submit -d "Add file author\\n" &&
> +
> +		P4USER=mmax &&
> +		>max.txt &&
> +		p4 add max.txt &&
> +		p4 submit -d "Add file max" &&
> +
> +		P4USER=eri &&
> +		>moritz.txt &&
> +		p4 add moritz.txt &&
> +		p4 submit -d "Add file moritz" &&
> +
> +		P4USER=no &&
> +		>nobody.txt &&
> +		p4 add nobody.txt &&
> +		p4 submit -d "Add file nobody"
> +	)
> +'
> +
> +test_expect_success 'Clone repo root path with all history' '
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config --add git-p4.mapUser "mmax = Max Musterman   <max@example.com> "  &&
> +		git config --add git-p4.mapUser "  eri=Erika Musterman <erika@example.com>" &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +		cat >expect <<-\EOF &&
> +			no <no@client>
> +			Erika Musterman <erika@example.com>
> +			Max Musterman <max@example.com>
> +			Dr. author <author@example.com>
> +		EOF
> +		git log --format="%an <%ae>" >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
> --
> 2.5.1
> 
