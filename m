From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Mingw: verify both ends of the pipe () call
Date: Fri, 28 Aug 2015 11:39:17 +0200
Organization: gmx
Message-ID: <d959c5ad8b7f57e76910ececce47b853@www.dscho.org>
References: <0000014f6fdf5839-19f5bc24-80bf-4b9e-a26b-2ef089a28f06-000000@eu-west-1.amazonses.com>
 <20150827215014.GA8165@google.com>
 <CAEdsdLdEC7KCgYeu8zmPZWm8uORCwshQo2u9FYQKjrq-sV_bZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: "Jose F. Morales" <jfmcjf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 11:39:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVG86-0007xz-6T
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 11:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbbH1JjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 05:39:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:57776 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbbH1JjV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 05:39:21 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MSdRI-1Z5zU20nJ6-00RXgM; Fri, 28 Aug 2015 11:39:18
 +0200
In-Reply-To: <CAEdsdLdEC7KCgYeu8zmPZWm8uORCwshQo2u9FYQKjrq-sV_bZg@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:mqeWqWdC8D18J8m4qO5OChTW7L0QHXgEtrwzZMQHb+AFKr7rfOG
 MotoheOWWIq+MPNzJo4urApM50AkmPRfL0aDTteRJr/Cs7zzuvn9gDMDQrta7vQEXIJJYdq
 OW8JS0aHuMwD+rnwDkrl7CtlUNwMjB+V1t8NsdFKF4vyPAA+qr75e96wHN0KU4TbTyz+hiz
 L2lJutXwD3bl5ZqoxR2mw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pDhFajUeIXE=:aziDRzcz9Im6d0JqPTXrHi
 jSCd2WJBql6jZAklzG6laesm6WI+vp9Qw68A5AslIjOfmZGrRAFtDpSguK+vLJosnO54xueiD
 jLUsa7rhzaBNfH7KbWgNcbKvC5aimQNIdAE+03UjcysjIc3n6Zt0EznzRuG4rkeHM3oMEbJRk
 hHgpmgG96Ki1nsKS6wS2UoBpdr+t1b9O3Zrmr7VGxlQ+35axZnJrGKSyyqPbnT44GcY0BpTP9
 uphrdx1StE5t7/bpNNf+JxETLk96Stoi637/0kFFq5S9JUrE1N6tbcV/0dwUqx0/ukTUZrJNN
 3t1KY0V6ZEESHcFxFPa2Rz4GqGv6O+obh87DlsCvp66NY3oUnpB2L+K3HBQ4lkco+8cxcVvi6
 1DTaAlNd7/UTxW4hVbeyyBx5wVWLLZy5dTh/xIaA5cDm47PA5YAJec5H/SYHJkYVvXpDkGw+A
 fFDDL5JddSDJtZsNXRenZjwO9GaWBQWbnZfkAZXfMVQopZvLV7cPlh/YEmWOtrIT6HjtzhjuK
 8vX5akECE5/jpdUh1UwsNlC5USMIGY1V+WP9wBtcwCYSyhWBVFZasDv/WQODAkdgt2qkbs3LE
 2cQ6WmPBIuKyA8N+XGE1UIdPjeuyFj3UxPwkvOT/41MCzDGEhViLj8zZm8tMyMMzlyD64auai
 5EEgDvw70Vnjk/XFlWCT/DUKSIJxTIN4mRgmu/xrpM/jXAx0GBfGNZi4iW3I910lNz71N+dUX
 SsTCoPXcUNtgfeEbqjAXxG1s71XalD+RK13RYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276710>

Hi Jose,

Please do not top-post; I use top-posting as a tell-tale for mails I can safely delete unread when I have too many mails in my inbox.

On 2015-08-28 08:37, Jose F. Morales wrote:
> Ops... my fault. I was playing with the web editor and forgot that my
> profile didn't had my real name (now it has).

Great!

> Could I still amend the commit? (it seems to be already pushed into master)

It was pushed to Git for Windows' master, but here it was submitted to the Git mailing list.

Junio, would you terribly mind fixing the name on your end? Alternatively, I could try to update the Pull Request and give submitGit another chance to show just how awesome it is.

Ciao,
Dscho
