Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF05207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 20:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424039AbdD1U3r (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 16:29:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:53690 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163948AbdD1U3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 16:29:45 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Luajs-1e3h7c24vI-00zrFl; Fri, 28
 Apr 2017 22:29:32 +0200
Date:   Fri, 28 Apr 2017 22:29:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Automating Coverity, was Re: [PATCH 00/26] Address a couple of issues
 identified by Coverity
In-Reply-To: <CAGZ79kYOp1deMgcEB3HHXeEcLOKNs4KPjdT_W2CD+4Amduv2Wg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704282205320.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <CAGZ79kbbHshh4=WC2ymG15=W5oq98b3KTV4zxiTx0LgCLeYwfQ@mail.gmail.com> <alpine.DEB.2.20.1704280010160.3480@virtualbox> <CAGZ79kYOp1deMgcEB3HHXeEcLOKNs4KPjdT_W2CD+4Amduv2Wg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gbnK3typ4jDd+UAYypGHj2vVJhKaolPKSquKAVSWtFa3LwImUtf
 RNMaTLiPRA27Ka1WibJIBFOdjiL3yT7r8sBn+tivWLwQ+qLtBS+4yD9pcTeNka9LygY5j4M
 0UNG2dqo+efVTMqYjyjhH6RRnBifgVURsQt5KkGIXCObC4AxbKxkGGxHpw7B7eCeCfBNeY7
 ftxyVk8nQTFFQMI/n1lJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KhCLX9OmcAM=:eMX3fBepxFGlaDxITCiKWy
 qUiCZfbOgH6rXktUykf7BH0W7D+ARIavKdex4URIOUme8jX0ZTTqSAi8SaXdl41nWY4bQgRd9
 Os9vBRdOMO+Vpp4CAwGehx6lgrvVyDNgOI0LGK6i4k2RlboYrTsw+4sg1um+dfMC0fpTBOeCL
 7T+XdsGPZVmGlVt1Ny7uv8K4xSiJNfpt6SB4OBrylJwfclfSaTSLf40UpFy0QFbZxA8GKkb0U
 nLQh24NjGmowLGwdrZ65wUDQiBVtE4HA1KunwzSrJJtfrZNoDIX9RdQRVH1YvCEB3PpoC5mE5
 fWq4/Dzj9L7+9OZfw8dyy90sLfJeEKJ4jArVURtSy6YfpHMe0nuDf5LAi961G67B7x7gLv/lN
 rHAnhWlla2RZQhsO0SANndvVhEKUjv9Tb7XoPLNsb0kGegon+JIlS6mZxKNDedlSAvu1KIv5I
 CAFUAk2x72k8tefjz8TyJBxfj5tKJXdgvvK8ar7N37p0Np184ifLBraMjCqeCUe9qGfTR2SjO
 qY1lZsBcrBbZyF+YVgCgVzDOip8W3EW44Dm/q9266+Y3j6jhJZ/pfMd+LlB3abfn5Bzw6MNxB
 FhXlBaE/Ews9katgocLMBClFmuMcu42jyf4lixBADhCiIm2iWmRm1kqVrWKqEhbNrtVhJP2zv
 S9E1FeQfrGcksMd7mqLXI86P78fq36btEQtKQF5qbP8jKxZBnCIoI5FcxLleh+pUM9Vp2nO/B
 fWJuHOPSiw7Oks2KJb/eHf39UqQvXPUrckBXN2WcCmdEqlQfeOjW/QMWUmEmeNh+q+QMSoCuH
 D16vj7I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 28 Apr 2017, Stefan Beller wrote:

> On Thu, Apr 27, 2017 at 3:50 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > I still have to find the time to figure out one more detail: how to
> > download and extract the Coverity tool (the .zip archive has a
> > variable name for the top-level directory), and doing that only every
> > once in a while, say, only when there is no previously unpacked tool,
> > or it is already 4 weeks old.
> 
> That is an interesting problem, which I ignored as the older versions of
> their tools still works once they release new versions. So I just
> manually check every once in a while if they have new versions out
> there.
> 
> So if you find a nice solution to that problem, let me know, please.

I think I have a working idea (jotting it down in the editor, untested):

	init_or_update_coverity_tool () {
		# check once per week whether there is a new version
		coverity_tool=.git/coverity-tool/
		test ! -d $coverity_tool ||
		test $(($(date +%s)-$(stat -c %Y $coverity_tool))) -gt
			$((7*24*60*60)) ||
		return

		curl --form "token=$(COVERITY.TOKEN)" \
			--form "project=git-for-windows" \
			--time-cond .git/coverity_tool.zip \
			-o .git/coverity_tool.zip.new \
			https://scan.coverity.com/download/win64 &&
		test -f .git/coverity_tool.zip.new || {
			# Try again in a week
			touch $coverity_tool
			return
		}

		mv -f .git/coverity_tool.zip.new .git/coverity_tool.zip ||
		die "Could not overwrite coverity_tool.zip"

		mkdir $coverity_tool.new &&
		(cd $coverity_tool.new &&
		 unzip ../coverity_tool.zip) ||
		die "Could not unpack coverity_tool.zip"

		rm -rf $coverity_tool &&
		mv $coverity_tool.new $coverity_tool ||
		die "Could not switch to new Coverity tool version"
	}

	init_or_update_coverity_tool
	PATH=$(echo $coverity_tool/*/bin):$PATH

I guess I will start from that snippet once I have time to work on that
Coverity automation.

BTW I stumbled over an interesting tidbit today: if you define FLEX_ARRAY
outside of git-compat-util.h, it will not be overridden by Git. That is,
if you want to use 64kB flex arrays by default, you can call

	make CPPFLAGS=-DFLEX_ARRAY=65536

No need to patch the source code.

Ciao,
Dscho
