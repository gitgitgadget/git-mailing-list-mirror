From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 03:09:39 -0700
Message-ID: <20130421100939.GI10429@elie.Belkin>
References: <1366458313-7186-5-git-send-email-artagnon@gmail.com>
 <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
 <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
 <7v8v4cwd6g.fsf@alter.siamese.dyndns.org>
 <CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
 <7vzjwsuxzp.fsf@alter.siamese.dyndns.org>
 <CALkWK0kEngwYQieR=Xmvzu+XqBe+ZFxiWj0C8M-euFavDDaD2Q@mail.gmail.com>
 <20130421080907.GF10429@elie.Belkin>
 <7vvc7guvu4.fsf@alter.siamese.dyndns.org>
 <CALkWK0nHbm4La4kJ6cNzEnMas5B7Q2M=z_9d+O6iNX2r2bi98A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 12:10:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTrDo-0004J7-CD
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 12:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab3DUKJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 06:09:59 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35113 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045Ab3DUKJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 06:09:49 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so2986426pdj.41
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=l0wKwyx5LRRTSo4ikY+hn829adCsL2n/Mw18wa6w5Go=;
        b=TeXfPRIpan/awETzlnl8cZPUge5aCRN/44fGrYzzY1249IBMUBQzuZZefpuMzI5VLx
         fqIQuQ3aqB9dqSrElTVpxqCyYNXxl5aKCueJcXi5x0yGEgh5aC0I3jwdLovuUg2Z+EsE
         yMZPnVk0HrTErbHKCF32BiMZmJkCsyhHrX94V7dhZD5qdsgg6xd+XcErxY8lJtNUWZLH
         4/cEOmZCYiC5l6GcHCccuFo2fWbyj/f8v2Wk9gdaLcLHpYsOsxa6iw3lTwLyPsXDWfBU
         2ybbsheY1a7Ofb7xNrJ5/Dh1C7r6Nl4NWPDwk+z9oXm0TmWw7VovbSNRMM563ynPfEee
         1nYw==
X-Received: by 10.68.226.106 with SMTP id rr10mr26764165pbc.127.1366538988724;
        Sun, 21 Apr 2013 03:09:48 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id o7sm20444165pbs.45.2013.04.21.03.09.46
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 03:09:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nHbm4La4kJ6cNzEnMas5B7Q2M=z_9d+O6iNX2r2bi98A@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221938>

Ramkumar Ramachandra wrote:

>                                               Why do you want to
> separate "revisions" (which are really just "extended SHA-1
> expressions" that incidentally resolve to commit objects) and
> "extended SHA-1 expressions that resolve to objects other than
> commits"?

No one I've met actually uses the word "revisions" to mean anything
other than the English-language meaning of "revisions", which in a Git
context is "commits".  There's value in matching common usage.
