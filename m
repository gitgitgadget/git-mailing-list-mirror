From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 15:16:04 +0530
Message-ID: <CALkWK0=T-ere6PFZxVuymjHwRWS6==p_W2Qy+mtN7eXj6qNZ0g@mail.gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-5-git-send-email-artagnon@gmail.com> <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
 <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
 <7v8v4cwd6g.fsf@alter.siamese.dyndns.org> <CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
 <7vzjwsuxzp.fsf@alter.siamese.dyndns.org> <CALkWK0kEngwYQieR=Xmvzu+XqBe+ZFxiWj0C8M-euFavDDaD2Q@mail.gmail.com>
 <20130421080907.GF10429@elie.Belkin> <7vvc7guvu4.fsf@alter.siamese.dyndns.org>
 <CALkWK0nHbm4La4kJ6cNzEnMas5B7Q2M=z_9d+O6iNX2r2bi98A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 11:46:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTqrC-0006tx-Hf
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 11:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980Ab3DUJqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 05:46:46 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:59796 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab3DUJqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 05:46:45 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so4579701iaf.32
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=iHmKq66K1/uwkSQoytI7c4wHYR3Z4qekU1ZUJuZ6H+I=;
        b=XUr9r9AvSwHKHFZGrUEynMzEnPBsBHULKq42l3qtdqlrYFKBNQYl2XqSgoyg5RvMNZ
         VXEsG/wLyCM19POWiYsPxR4pxxx8I3dG+HOzeyW5zwHS7MBAptXRZXfg3ws7K3jAK8Wv
         ivl1ZfsGW0JblPFw+YgwQNt7kBMI2+P0RM7U/eJNpSM3kvexrxtYR9wXipVXImbmhoxP
         6YohdMO81kwl/OW8gQF3rZSSCzAg7Xg5dOPKHBWX8cnAzkmfMEgCHfQCUZkwt7vwW/mU
         0KBLshBhLtyLQIds+kxLH7f+2NlriMvFXZC2lre+iKrpPZfDEnWgHbdS1xuy/sc5M1RH
         zHpA==
X-Received: by 10.50.119.102 with SMTP id kt6mr13004379igb.12.1366537604565;
 Sun, 21 Apr 2013 02:46:44 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 21 Apr 2013 02:46:04 -0700 (PDT)
In-Reply-To: <CALkWK0nHbm4La4kJ6cNzEnMas5B7Q2M=z_9d+O6iNX2r2bi98A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221937>

Ramkumar Ramachandra wrote:
> For the record, 'git rev-parse master:README..HEAD@{3}~2' works just
> fine.  I don't know whether you want to consider it "sensible" or not,
> but the current revisions.txt is consistent with this.

rev-list errors out though:

  error: Object 15bfea is a blob, not a commit
  fatal: Invalid revision range master:README..HEAD@{3}~2

Hence my suggestion to change the meaning of what a valid "revision
range" is (using rev-list as the guideline) , and be done with it.
