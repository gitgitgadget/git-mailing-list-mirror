From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 03/26] t1400: Pass a legitimate <newvalue> to update command
Date: Tue, 11 Mar 2014 17:41:18 -0400
Message-ID: <531F82FE.9030305@kitware.com>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu> <1394455603-2968-4-git-send-email-mhagger@alum.mit.edu> <531DF079.9050909@kitware.com> <531E30D7.40208@alum.mit.edu> <xmqqa9cwpkiw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 11 22:40:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNUPm-0001jq-91
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 22:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbaCKVkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 17:40:41 -0400
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33802 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752213AbaCKVkj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Mar 2014 17:40:39 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]) (using TLSv1) by na3sys009aob110.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUx+C1qSsZeRA3fFR9fRrw1EkPtneohMe@postini.com; Tue, 11 Mar 2014 14:40:39 PDT
Received: by mail-oa0-f47.google.com with SMTP id i11so9289001oag.34
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 14:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Z7tYyCR0kS32HBer8ot3SRViBQjRPoNJ7WwI7tW1YAw=;
        b=mrhXJBXjTCXxXj9FvaKj32SoB+h/pEr4rE/yT6cJHb4yeWKFhxLq4RmY6qVgPGBcmv
         yzx8EeMLGgtLKlS8n0024vowsMfMzv0Vz8gEAP2U3H7Mqyfg6VX3JB4fyXki13ODfoNI
         ECqeaj8vUOLSNNqrDL8eoFTGrjfs7xp4jUl/2uL/yAg1dyMf0QtV+SpjYy2VXEDe+0aI
         Q8LshMMyDnWGFQzTnTneIPnawrZUHgLoOacWtUt+wzoJAucb17my7Z+cJtR3E6BU6YL3
         OLY6QmiakNF/xAkIxsn1OZtPDvPoN+73rXhoT8mg71NOf+qWVovcyGIuTk62jKdHJLFi
         X3qA==
X-Gm-Message-State: ALoCoQl4cEafppCa4iJd5poiQroYqhK1G2o5GtDQ805Qihdgyt9Q5zQk4F+QGIOyxNS6pozHmmGNNJSw+2sQlTKmCbOjjwfnspP9SgBMBC/5q2fjmD1iWrGEp0JGoAjRE7imy3sv+4KzhVsHvK0VfBkDEBJewpvpiA==
X-Received: by 10.182.233.201 with SMTP id ty9mr35757234obc.29.1394574036470;
        Tue, 11 Mar 2014 14:40:36 -0700 (PDT)
X-Received: by 10.182.233.201 with SMTP id ty9mr35757223obc.29.1394574036336;
        Tue, 11 Mar 2014 14:40:36 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id wc1sm60553126obc.2.2014.03.11.14.40.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Mar 2014 14:40:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqa9cwpkiw.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243902>

On Tue, Mar 11, 2014 at 4:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I may be misremembering things, but your first sentence quoted above
> was exactly my reaction while reviewing the original change, and I
> might have even raised that as an issue myself, saying something
> like "consistency across values is more important than type-saving
> in a machine format".

For reference, the original design discussion of the format was here:

 http://thread.gmane.org/gmane.comp.version-control.git/233842

I do not recall this issue being raised before, but now that it has
been raised I fully agree:

 http://thread.gmane.org/gmane.comp.version-control.git/243754/focus=243862

In -z mode an empty <newvalue> should be treated as missing just as
it is for <oldvalue>.  This is obvious now in hindsight and I wish I
had realized this at the time.  Back then I went through a lot of
iterations on the format and missed this simplification in the final
version :(

Moving forward:

The "create" command rejects a zero <newvalue> so the change in
question for that command is merely the wording of the error message
and there is no compatibility issue.

The "update" command supports a zero <newvalue> so that it can
be used for all operations (create, update, delete, verify) with
the proper combination of old and new values.  The change in question
makes an empty <newvalue> an error where it was previously treated
as zero.  (BTW, Michael, I do not see a test case for the new error
in your series.  Something like the patch below should work.)

> I am not against deprecating and removing
> the support for it in the longer term, though.

As I reported in my above-linked response, I'm not depending on
the old behavior myself.  Also if one were to start seeing this
error then generated input needs only trivial changes to avoid it.
If we do want to preserve compatibility for others then perhaps an
empty <newvalue> with -z should produce:

 warning: update $ref: missing <newvalue>, treating as zero

Then after a few releases it can be switched to an error.

Thanks,
-Brad


diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 3cc5c66..1e9fe7c 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -730,6 +730,12 @@ test_expect_success 'stdin -z fails update with bad ref name' '
 	grep "fatal: invalid ref format: ~a" err
 '

+test_expect_success 'stdin -z fails update with empty new value' '
+	printf $F "update $a" "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: update $a: missing <newvalue>" err
+'
+
 test_expect_success 'stdin -z fails update with no new value' '
 	printf $F "update $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-- 
1.8.5.2
