From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/WIP v3 07/31] am: extract patch, message and authorship
 with git-mailinfo
Date: Fri, 19 Jun 2015 22:12:42 +0200
Organization: gmx
Message-ID: <87fa23332f7435292bcac1b0235d77bd@www.dscho.org>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
 <1434626743-8552-8-git-send-email-pyokagan@gmail.com>
 <xmqqtwu4d8pg.fsf@gitster.dls.corp.google.com>
 <CACRoPnS9eyBF5NEM7sKvep+A8aKUNLJDaV-1c_oWDBwMcv26Bg@mail.gmail.com>
 <CAPc5daVbpB_T4cY1xvLrBKPUZw0JNMXqNAOsKE-R7NPO2nrnZA@mail.gmail.com>
 <CACRoPnQdR7qC6gH7j9_8gQUYKShLRQCr6GNtmn+XCpe9P4P-nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:13:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z62ek-0003WO-V6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbbFSUMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:12:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:51857 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbbFSUMt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:12:49 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MWCKz-1ZdCa505pB-00XOmu; Fri, 19 Jun 2015 22:12:44
 +0200
In-Reply-To: <CACRoPnQdR7qC6gH7j9_8gQUYKShLRQCr6GNtmn+XCpe9P4P-nA@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:7/K5csIKyrdQbB9EwWl7ZBPEESCQlZVzK/2ANgmwN4690ExrFc2
 72n7KPEVj16cA4MPjsEVP07A/EkXHy/Jn/1hazNt4q/BBApPHMLPyd7xzvKRxYC4L3pe40M
 HrYRac7amnyWaO6v9O8f+wxF4xWrGl8gueJQoPmEDtQwQ4xCCC+m3CUpvhTudbqSUsutyPt
 6Gcy7dcIARtn93r5dTWRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+YSBr94Mnfc=:qlDsDK/9a8dum7QKyLzVDI
 3K01FFDSBtA9NJ4cUOsLwk/2to4nYtrC4kv0L1O8jBDSUhHv1mEtqMfyh/IBBGHSCoK1xuhbp
 6olPazy/LbVe1MH1TgenGCSfcJs/PY6RGNCJ2hpERpuA8om0RSp04u1Bgrn857ZA3hhSl0ZeV
 hMIlKs4heu6H4h6YqUiNCsTQsiAH3nqcpG7/F+Rpex73luwDA7DiButmWiCsKUZbS1SZJkayn
 nsasm82BezZ7LytE45QQx4v7uPgOgdNk8MtYL0LN1keukHNYV9Z2sYotyHAn1ItQ55T2IgW/i
 0fjDrCbgYmLyl6E2AgzZ2r9i3MRb1BZmOJvGxsYQEJ9ATjadb2DIiSkr5MGeXCaoHMPdFZiF/
 KYRyBVJtp/pq7secLSYf3Q/9Y2MM+n47xm563KfV+nkbAe+bDwOmXI4mXZAwkkcj8bAr8fgJR
 OR6E7RE0wjqyBBrQbDj1BgBnAsB0YRwxLAH2y2R7kVs5USljpZpsOaGJm9hhtyEh6c1KXclw5
 oss/1ilJsaYP9eg/FnTjbP8pUVpqP4rHLwvyt+u4UZwj+PCelVPrXrhh6BvDJaMP94+YmpOHm
 M0eGk950oXUhDOXdpnbBV/f2cL+Yf+xJ7E0iFFpB4rmg9aTBDPU2i253jjq5aYGzFxagwHB41
 rZ77oTXvqkvqGr0tfvB1vJYHqoF5FOAKMT4S8wB3nxApuc/qV3zOkZ5eRi4gMQTNrijA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272192>

Hi Paul,

On 2015-06-19 18:15, Paul Tan wrote:
> On Fri, Jun 19, 2015 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
>> The primary thing I care about is to discourage callers of the API element
>> am_state from touching these fields with strbuf functions. If it is char * then
>> the would think twice before modifying (which would involve allocating the
>> new buffer, forming the new value and assigning into it). With the fields left
>> as strbuf after they are read or formed by the API (by reading by the API
>> implementation from $GIT_DIR/rebase-apply/), it is too tempting to do
>> strbuf_add(), strbuf_trim(), etc., without restoring the value to the original
>> saying "I'm the last user of it anyway"--that is the sloppiness we can prevent
>> by not leaving it as strbuf.
> 
> I don't think this is a good deterrent. If the code wanted to, it
> could just use strbuf_attach()/strbuf_detach() as well, no?

Sadly, I am a bit too busy with some loose Git for Windows ends, so I haven't had the chance to look at your code.

But I still wanted to throw this idea out there: would it maybe possible to avoid having those values as global variables, and instead pass them as const char * parameters to the respective functions? That should help resolve the concerns of both sides because it would allow us to keep the strbuf instances, just as local variables.

Ciao,
Dscho
