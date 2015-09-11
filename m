From: Vitali Lovich <vlovich@gmail.com>
Subject: Re: --progress option for git submodule update?
Date: Fri, 11 Sep 2015 16:34:21 -0700
Message-ID: <8B026E5E-5303-45EC-984D-3F944DB6F2DB@gmail.com>
References: <88E7FC00-9A87-4E20-89D8-4BF5997F7B07@gmail.com>
 <CAGZ79kYRYqVE35_i5+DvqOj7G6LvhBQgsQok5gabLY6x20F80w@mail.gmail.com>
 <68DDAE70-85F2-4873-BDBD-373985A49815@gmail.com>
 <CAGZ79kbH+917v6pmCC3w4rovEVarHp+w1tYthMwkMU2hrq=VdQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3083\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 01:34:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaXpr-0003EE-Fu
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 01:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbbIKXeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 19:34:23 -0400
Received: from mail-out4.apple.com ([17.151.62.26]:49448 "EHLO
	mail-in4.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752691AbbIKXeW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 19:34:22 -0400
Received: from relay6.apple.com (relay6.apple.com [17.128.113.90])
	by mail-in4.apple.com (Apple Secure Mail Relay) with SMTP id 70.12.13836.8F463F55; Fri, 11 Sep 2015 16:34:16 -0700 (PDT)
X-AuditID: 11973e12-f79f96d00000360c-40-55f364f80c4b
Received: from marigold.apple.com (marigold.apple.com [17.128.115.132])
	(using TLS with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by relay6.apple.com (Apple SCV relay) with SMTP id 53.48.22881.8F463F55; Fri, 11 Sep 2015 16:34:16 -0700 (PDT)
Received: from vldesktop.apple.com ([17.214.197.172])
 by marigold.apple.com (Oracle Communications Messaging Server 7.0.5.30.0 64bit
 (built Oct 22 2013)) with ESMTPSA id <0NUJ006Q9DH4L910@marigold.apple.com> for
 git@vger.kernel.org; Fri, 11 Sep 2015 16:34:16 -0700 (PDT)
In-reply-to: <CAGZ79kbH+917v6pmCC3w4rovEVarHp+w1tYthMwkMU2hrq=VdQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3083)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsUi2FAYpfsj5XOowYGNBhZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4Mq4uGslY8F3loqe/e+ZGhi/MXcxcnBICJhIvJxe28XICWSKSVy4
	t54NxBYS2Mso8f6tN0zJpyPSXYxcQOFJTBI93y5A1UxhkrjSxwFiCwtISKy8cZgdxGYW0JJY
	v/M4E4jNK6An0bxxAjtEjYXE8U3HmUFsNgF1iS+tM8HinALBEvtXnwSLswioSjw4PYcVYo6+
	xIf+JjYIW15i85q3zBAzbSQ2TDjMCnHQX0aJjSsegBWJCKhJzFw1mw3iaFmJadviQWokBH6y
	Skw/M5V1AqPILCT3zUJy3ywkOxYwMq9iFMpNzMzRzcwz0UssKMhJ1UvOz93ECArs6XZCOxhP
	rbI6xCjAwajEw2uh+ilUiDWxrLgy9xCjNAeLkjjvdgOgkEB6YklqdmpqQWpRfFFpTmrxIUYm
	Dk6pBsbK5UmSEjMOCL7PjPR1SVm4J2UJ/4wdNpOX7Y38z9u3UThC6Y5t/wrvG+UTe0+6z1ad
	0rJGNKrC8nV48TPDRZG2psceLnw6/+nx+Y6G31Ra56urWBw7I3/Z4HxH1K/ABZcvLtv/vPB4
	K//FUqfVW39c1lTn8lupE8ZzlD3YdJ8k6+eFvNOYZrorsRRnJBpqMRcVJwIAOO+Sok0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsUi2FDcovsj5XOoweeNuhZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4Mq4uGslY8F3loqe/e+ZGhi/MXcxcnBICJhIfDoi3cXICWSKSVy4
	t56ti5GLQ0hgEpNEz7cLbCAJIYEpTBJX+jhAbGEBCYmVNw6zg9jMAloS63ceZwKxeQX0JJo3
	TmCHqLGQOL7pODOIzSagLvGldSZYnFMgWGL/6pNgcRYBVYkHp+ewQszRl/jQ38QGYctLbF7z
	lhlipo3EhgmHWSEO+ssosXHFA7AiEQE1iZmrZrNBPCArMW1b/ARGwVlITpqF5KRZSMYuYGRe
	xShQlJqTWGmml1hQkJOql5yfu4kRHIyFUTsYG5ZbHWIU4GBU4uG1UP0UKsSaWFZcmXuIUYKD
	WUmEt1j4c6gQb0piZVVqUX58UWlOavEhRmkOFiVx3gaRV6FCAumJJanZqakFqUUwWSYOTqkG
	xsKfF4rvd7+ZqHv/lCP3gePv3lyT+P80S80ha0+HiriQsbjK7sb3bfae/fMPPJ7uWdl0eodn
	jVzh5Adve3pUUiLXBj5TD428ui/l35xQg6SDF5v0HikuatvdKsQob3ap7xUbz1XNfcYsxje3
	f5nomn34fMk2dt/dct7fql3WxDqtmLTqxTOJC0osxRmJhlrMRcWJAEq2FRVCAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277711>

& then do a git submodule init?

> On Sep 11, 2015, at 4:05 PM, Stefan Beller <sbeller@google.com> wrote:
> 
> On Wed, Sep 9, 2015 at 8:06 PM, Vitali Lovich <vlovich@gmail.com> wrote:
>>> Doh! I see what you're missing now after rereading the email closely.
>>> You can add a --quiet option,
>>> but --verbose or --progress just errors out, but you want that as a
>>> possible argument for git clone
>>> inside the git submodule update code.
>> Yes exactly.
> 
> Instead of cloning with submodules, you could also clone only the
> superproject and then do a git fetch --recuse-submodules=yes -v
> instead soonish.
