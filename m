From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Thu, 26 Feb 2015 17:26:40 -0800
Message-ID: <CAGZ79kayaD792tvfySQFXsmk==p=V4+aw+c79RM1eCZED-yzsQ@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
	<CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
	<xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
	<xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 02:26:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR9hX-00007l-Kz
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 02:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbbB0B0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 20:26:43 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35571 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbbB0B0m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 20:26:42 -0500
Received: by iecrl12 with SMTP id rl12so23996550iec.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 17:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pu+HV1hm1vro26hQUideRMCEEfAjiGj3EKq2tn+KxW8=;
        b=XjFtwdLQ+wC40eA9jbEDVeHbKkYO2VW50CeXnnmK92ZZhcm6WhDSFkOqwiHNEN9yNo
         h8w8dzOEQxFdm7z7KLsoxPEYhQCDsO/AnfeDdZwUUugtSIDYtZBizLHfMcFkEXRktX8c
         rZOpYTxQxKhXrFThdHVpSIa+U9YESlJNTKTnai0cbxehFIvtri5cn9n6ZAwVwS4i1fFe
         2W1SWsH9hbyJrcPglXWeeU6MnLt9eCp1UwZceNn5ETkJA/bz9fy1Uxg7rStS3t5eoj97
         NYfFySaSf6NP4cNbISo4rE+nRBUq5kOyE4NDDytGL/BH4ce70WIRB4IrlICNS1fKYPLq
         7xYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pu+HV1hm1vro26hQUideRMCEEfAjiGj3EKq2tn+KxW8=;
        b=YVmorm9EcpV4pImjzcx9IifaMvFFgO+/44y0IYjYwvOFEtTW/aRxvR30svQ+3VG8ih
         wA7jJPOvE/GM1gDz1Q/V28grao8xOV6Pn6xvSfkmkbXwzkbJBCuHQharwaD8H1HadT7I
         PsRuph6bJDl3pchP+70WKVbdfVY/EauV+I5bkOiKFh5jeg1ZEGV68APpMsBC3oRsoEFC
         dWRsCocPv5/SOwKdbpZK6X2fLmpgdDiLCwUaduzaFxOoLf3O4v6166dNY6b80WqxW1E1
         9GCr/XbVtkGMykDq0+JiETqSv5+1yMX1nxrIlj6OC1vb70HuwvweUU/F48PnTLZNdooR
         r5Qw==
X-Gm-Message-State: ALoCoQlPu0FgS3drT7kOeXmgfiqG0AS7g517gulPBr6DF85CtnffaB4BBJOqLRYDMoQs7/aWCLjS
X-Received: by 10.43.100.67 with SMTP id cv3mr13069552icc.92.1425000401015;
 Thu, 26 Feb 2015 17:26:41 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Thu, 26 Feb 2015 17:26:40 -0800 (PST)
In-Reply-To: <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264485>

On Thu, Feb 26, 2015 at 12:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Step 1 then should be identifying these wrongdoings and assumptions.
>>
>> We can really go wild with these capabilities. The only thing that
>> can't be changed is perhaps sending the first ref. I don't know
>> whether we can accept a dummy first ref... After that point, you can
>> turn the protocol upside down because both client and server know what
>> it would be.
>
> Yes, exactly.  To up/down/side-grade from v1 is technically
> possible, but being technically possible is different from being
> sensible.  The capability-based sidegrade does not solve the problem
> when the problem to be solved is that the server side needs to spend
> a lot of cycles and the network needs to carry megabytes of data
> before capability exchange happens.  Yes, the newer server and the
> newer client can notice that the counterparty is new and start
> talking in new protocol (which may or may not benefit from already
> knowing the result of ref advertisement), but by the time that
> happens, the resource has already been spent and wasted.
>
> I do not think v1 can be fixed by "send one ref with capability,
> newer client may respond immediately so we can stop enumerating
> remaining refs and older one will get stuck so we can have a timeout
> to see if the connection is from the newer one, and send the rest
> for the older client", because anything that involves such a timeout
> would not reliably work over WAN.
>
>> You realize you're advertising v2 as a new capability, right? Instead
>> of defining v2 feature set then advertise v2, people could simply add
>> new features directly. I don't see v2 (at least with these patches)
>> adds any value.
>
> I agree with the value assessment of these patches 98%, but these
> bits can be taken as the "we have v2 server availble for you on the
> side, by the way" hint you mentioned in the older thread, I think.
>
>> And we already does that, except that we don't state what version (as
>> a number) exactly, but what feature that version supports. The focus
>> should be the new protocol at daemon.c and maybe remote-curl.c where
>> we do know the current protocol is not flexible enough.
>
> The "first" thing the client tells the server is what service it
> requests.  A request over git:// protocol is read by "git daemon" to
> choose which service to run, and it is read directly by the login
> shell if it comes over ssh:// protocol.
>
> There is nothing that prevents us from defining that service to be a
> generic "git service", not "upload-pack", "archive", "receive-pack".
> And the early protocol exchange, once "git service" is spawned, with
> the client can be "what real services does the server end support?"
> capability list responded with "wow, you are new enough to support
> the 'trickle-pack' service---please connect me to it" request.
>

So I am not quite sure how to understand this input.

I wonder if a high level test could look like the following,
which just tests the workflow with git fetch, but not the
internals.

(Note: patch formatting may be broken as it's send via gmail web ui)
---8<---
From: Stefan Beller <sbeller@google.com>
Date: Thu, 26 Feb 2015 17:19:30 -0800
Subject: [PATCH] Propose new tests for transitioning to the new option
transport.capabilitiesfirst

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5544-capability-handshake.sh | 81 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100755 t/t5544-capability-handshake.sh

diff --git a/t/t5544-capability-handshake.sh b/t/t5544-capability-handshake.sh
new file mode 100755
index 0000000..aa2b52d
--- /dev/null
+++ b/t/t5544-capability-handshake.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description='fetching from a repository using the "capabilities
first" push option'
+
+. ./test-lib.sh
+
+mk_repo_pair () {
+ rm -rf workbench upstream &&
+ test_create_repo upstream &&
+ test_create_repo workbench &&
+ (
+ cd upstream &&
+ git config receive.denyCurrentBranch warn
+ ) &&
+ (
+ cd workbench &&
+ git remote add origin ../upstream
+ )
+}
+
+generate_commits_upstream () {
+ (
+ cd upstream &&
+ echo "more content" >>file &&
+ git add file &&
+ git commit -a -m "create a commit"
+ )
+}
+
+# Compare the ref ($1) in upstream with a ref value from workbench ($2)
+# i.e. test_refs second HEAD@{2}
+test_refs () {
+ test $# = 2 &&
+ git -C upstream rev-parse --verify "$1" >expect &&
+ git -C workbench rev-parse --verify "$2" >actual &&
+ test_cmp expect actual
+}
+
+test_expect_success 'transport.capabilitiesfirst is not overridden
when set already' '
+ mk_repo_pair &&
+ (
+ cd workbench &&
+ git config transport.capabilitiesfirst 0
+ git config --get transport.capabilitiesfirst 0 >expected
+ )
+ generate_commits_upstream &&
+ (
+ cd workbench &&
+ git fetch --all
+ git config --get transport.capabilitiesfirst >actual
+ test_cmp expected actual
+ )
+'
+
+test_expect_success 'enable transport by fetching from new server' '
+ mk_repo_pair &&
+ (
+ cd workbench &&
+ git fetch origin
+ ) &&
+ generate_commits_upstream &&
+ (
+ cd workbench &&
+ git config --get transport.capabilitiesfirst >actual &&
+ echo "1" >expected &&
+ test_cmp expected actual
+ )
+'
+
+test_expect_success 'test new transport still works' '
+ # continue from last test
+ generate_commits_upstream &&
+ (
+ cd workbench &&
+ git fetch origin
+ )
+ test_refs HEAD refs/remotes/origin/HEAD
+ test_refs master refs/remotes/origin/master
+'
+
+test_done
-- 
2.3.0.81.gc37f363
