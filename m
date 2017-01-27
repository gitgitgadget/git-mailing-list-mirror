Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1267A1F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 10:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932531AbdA0Kny (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 05:43:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:58829 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932522AbdA0Kmm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 05:42:42 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSHax-1cuTbi14xP-00TSdG; Fri, 27
 Jan 2017 11:35:41 +0100
Date:   Fri, 27 Jan 2017 11:35:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] connect: Add the envvar GIT_SSH_VARIANT and
 ssh.variant config
In-Reply-To: <xmqqo9yt4o5i.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701271132270.3469@virtualbox>
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de> <cover.1485442231.git.johannes.schindelin@gmx.de> <3d451f2c357a3fd7f0b0e4b427548553d7d05306.1485442231.git.johannes.schindelin@gmx.de>
 <xmqqo9yt4o5i.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JAKNbrCNQAAV0CMXjfaPuuLAaWinnx7S20RlT5hORbuhAsJdCTW
 6WkScZTyw2nJpreBNn14U/J/dzu0NGeQkJdjJjS38WPXjrtPsCOe7T06deD9eejOj21SPU9
 EthyziBKSLDouVrkMxzYdgJramgdyBeA3Cww+0FUmawJ24s2iOTmjQv/OhZ+RtstrKtDW6v
 KxLx/H3WusE3Y3sAFws4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BM4mdFPRMJA=:k/19oioB2gHUfqJrB5ZM5X
 Z7Rw+AQ7m85uRPPB3ErGHDnHp7/vvFIsXP9hFswSrcKqg3cUppR0eFeFxBh7kJOTCvVL5RaLg
 sHFanz4rvZVtT64dzL2BISA78L+w/kUuYVHgjUOWw0jhjot+K2dPg+4vjiCrwdvcvqXziZNi0
 YNWQlfcLa01rlAvqdHi/oG82UzB+uHYo2vljxSlGu+jENtogwWD9NQRrLjmyoGTGHXfCX+zD2
 RkGT8lYlFZrwnMNE5S5DbcPc/i9pckDShrlViCql0zUp3MxLi05Ugq8GACGoackjxbXb/AhAC
 kYX1nuHADp7oH+xknwCxO4M3QjV2fCCzUQJPBQRIEc42Qhu9Xz4rzvy6h5RJbWszUkbdZrQLj
 3j47C6zkQsi0hZWaOVAtbFYYC1zuwGI9T+QMzUljf07F6hYdMAy+w9b0Lkhaw8F6mVMGmQeGw
 uRi1YT1cpZP2TO9sj8nsbrGm1HfWYDWgZoV5x3dzKprlJIuoB3+7j921aC6qNiFqMD+CTuKPJ
 k6+xOMroLJGJOK1c0wmLvHlTNCFsuyFMz7qjr9ujoj181SCO0sup5xzERYjXa2POwvHOi3lsJ
 qzqPIbiapiWTI6uuaY0H8yfit6OpdaghOMccMGa0R2623TpsNetiYXBzl9Ur6xHL9yPtBYk9n
 0muYmEiSMa5RtUuQVN/WuE9qjT4N9UjcjvfiYI6PiPkXwRFlQcyrq5pw4hFPzSFEH0F3pT5M+
 eSHUtWIEpMpn4j26SDjLSLSGA6P7+9FNhl1rPLmqKb4lXpXnQAU+kec38SBhHUvy8ZHG81M6C
 rqaJ91jLnMhuZi44wrZgNO9qERzKS1suYWWA3KlCq0WHDRYsv1jUA1i+T+UEDNkkHLi0AR59i
 4M3BZrDV/QN5bHmSpc8ckF85jGxWwWXeSFycZmQkaOmUYIzgjgjH5Kt8283VlY47C0jkepG+c
 W+PWMCWS4WoEKXmG1MmdfgL6hUHwM6HIzjmQzamwtAh+mAwdpQI1HzpBE8anHkYbQgPTMAxeI
 4vJROTglm/4Gd9vGGWPsFqaM2/+f0pcIyj7Z+lGn+y2JaHV+Z0SJKyQ5yL+bDIcCAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 26 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/connect.c b/connect.c
> > index 9f750eacb6..7b4437578b 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -691,6 +691,24 @@ static const char *get_ssh_command(void)
> >  	return NULL;
> >  }
> >  
> > +static int handle_ssh_variant(int *port_option, int *needs_batch)
> > +{
> > +	const char *variant;
> > +
> > +	if (!(variant = getenv("GIT_SSH_VARIANT")) &&
> > +		git_config_get_string_const("ssh.variant", &variant))
> > +		return 0;
> > +
> > +	if (!strcmp(variant, "plink") || !strcmp(variant, "putty"))
> > +		*port_option = 'P';
> > +	else if (!strcmp(variant, "tortoiseplink")) {
> > +		*port_option = 'P';
> > +		*needs_batch = 1;
> > +	}
> > +
> > +	return 1;
> > +}
> 
> Between handle and get I do not think there is strong reason to
> favor one over the other.

That is correct. "handle" and "get" are two very beautiful words, and none
of them deserves to take a back seat behind the other.

In this case, "get" is inappropriate, though, as the function does not
return the ssh variant, nor does it assign the ssh variant to any variable
to which any of its argument points.

Will try to find the time to address the other issues soon,
Johannes
