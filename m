From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [GSoC] Introduction and Project Discussion
Date: Sun, 20 Mar 2016 16:55:00 +0100
Message-ID: <C1CDE4AB-2175-42D6-BC0A-0900E3AF1852@gmail.com>
References: <CAJj6+1Ewdn_FNHR-qPqYzKEfQ6kgjXRBvc7dzMLK_2pPKukRvg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chirayu Desai <chirayudesai1@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 16:55:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahfhA-0005TH-WD
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 16:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbcCTPzI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2016 11:55:08 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38272 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbcCTPzF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2016 11:55:05 -0400
Received: by mail-wm0-f46.google.com with SMTP id l68so95018675wml.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8CHcx4dcQb/4JI4ahXRlFUCVVjW0mgcC3sKjNtHxWSc=;
        b=SRGP8J1bgR7obJDpAMYV9QRLWPYguqjuSeyu66VcXsSpTTzeRYndJPxzfUxf+Da9gP
         7dvDGkf1cepvCWaJ5PFjYx2mktSSP83QVQ3o9eOc72mvIjfRgx1duEUXaMM55ZIVryTE
         qv6u2f5m6J0/zFb1Q2kmboCz8fqD6fkbhvXOTAbkMssjL5wKhjKg/P8zcmZDTArNi0jk
         pNPxVs4YkcDf3m8/jqlbrW6bhwGEUeLbWXPMJcZWD6RfOWWGPxA5wZemahPuLxkCNHxW
         iLu0xpbH17pxzDFAFavm9UlIPNSWybaWsa7n233D0w3GEo3UXiUdaHvpiiYq5T2/6KTO
         rkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8CHcx4dcQb/4JI4ahXRlFUCVVjW0mgcC3sKjNtHxWSc=;
        b=aiL1p1ooHln2CDV1D2Vs/tZu+r5Ka5n0EFRosAYDeS1K9vnQKvQM0T4CRVyBTd1id6
         g1BA3yq0Nq/j8QHu1WSxNbmUZ4YwjAHCIUw++MI0E6apQL+2QQqPcr1Av+vp2iS2ub8i
         YOpxeJp6pPXgJU38f2JZY13l/HjnHnavNQl7FKPQNYyRMsHtNicnLZUoH7LGr106ytmw
         KadxwlDmSj8oIWnnv4P9yReOysAocXrYqynYvhFl3zDCjsN9JSkwDC/l1eb51B5rUgIT
         3T4sb9Fdz130aqhNddJisowEjYxQEP5f5BIcOwFcH1DIkmQT3cH2vUG2wDIsCSfwvF+K
         Zrbw==
X-Gm-Message-State: AD7BkJL9Jjqe7rU75w488H+H5LiztDbVRDf6JqHEjhIPiAny6hgSyhBPDhcbngXKdaitBA==
X-Received: by 10.194.63.7 with SMTP id c7mr25980054wjs.168.1458489304357;
        Sun, 20 Mar 2016 08:55:04 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB416B.dip0.t-ipconnect.de. [93.219.65.107])
        by smtp.gmail.com with ESMTPSA id e25sm8288541wmi.21.2016.03.20.08.55.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Mar 2016 08:55:03 -0700 (PDT)
In-Reply-To: <CAJj6+1Ewdn_FNHR-qPqYzKEfQ6kgjXRBvc7dzMLK_2pPKukRvg@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289361>


On 19 Mar 2016, at 18:36, Chirayu Desai <chirayudesai1@gmail.com> wrote=
:

> Hi,
>=20
> I am a first year computer engineering student from India, studying a=
t
> the Silver Oak College of Engineering and Technology,
> I had already put part of this in "[PATCH/GSoC] pull: implement
> --[no-]autostash for usage when rebasing", but at that time I didn't
> notice that another student was already working on the same change,
> and I would like to apologise for that, it was totally unintentional.
>=20
> I have since picked another microproject, "Make =93git tag --contains
> <id>=94 less chatty if is invalid", and after looking at the code, it
> would have the same effect for any command with has a "--with" or
> "--contains" option, which currently are 'tag', 'branch', and
> 'for-each-ref'.
>=20
> I have worked on OSS in the past (and am currently semi-active as
> well, working as a device maintainer with CyanogenMod, an android
> distribution)
>=20
> I would like to work on "Git remote whitelist/blacklist". The current
> example on the ideas page [1] looks like something that wouldn't be
> too much trouble to implement. Still need to dig a bit more on that.

That sounds great. I consider the posted idea as just something to get
you started. If you see ways to improve the idea then I would be super
interested. E.g. we might need a mechanism for exceptions (either
permanently in the config or via command line flag).

- Lars

>=20
> I also saw Thomas Gummerer's idea on the list [2], seems like a reflo=
g
> on steroids?
> I still don't understand the entirety of that, so some clarity on tha=
t
> would be nice.
> It also seems a bit complex
>=20
> Apart from this, I was also interested in the "git config --unset
> improvement" idea, as currently something as basic like
> `git config --global foo.bar 1 &&
> git config --global --unset foo.bar`
> leaves a section [foo] in the config.
> I would like to try to solve this in some way without having to
> rewrite the parser, but if that can't be done easily then I'm open to
> doing it any other way as well.
>=20
> So, to sum it up,
> I would like to work on "Git remote whitelist/blacklist", and if the
> mentors deem it to not take too much time / not be too hard of a task=
,
> I could also try to look at the configuration parser.
>=20
> Thanks,
> Chirayu Desai
>=20
> [1]: http://git.github.io/SoC-2016-Ideas/
> [2]: http://article.gmane.org/gmane.comp.version-control.git/286708
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
