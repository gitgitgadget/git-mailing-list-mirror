From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/6] implement notes.mergeStrategy
Date: Mon, 17 Aug 2015 15:35:19 -0700
Message-ID: <xmqqfv3hbl20.fsf@gitster.dls.corp.google.com>
References: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 00:35:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRT05-00033Y-W9
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 00:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbbHQWfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 18:35:24 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33396 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbHQWfV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 18:35:21 -0400
Received: by pabyb7 with SMTP id yb7so117414613pab.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1LxRcBqTYdm3O88k8pVyclim76yHXEYUDBBS+s0kBTc=;
        b=MK363qj8L3V/6wZ078mMzijEID2fS6NdrBnoQdh+h4dAhXl+SwZFRfuRIOmzfgFWjB
         6drHm6XZTdYyL3AxgKkyOu3hhRIonJs7UI09p/TG9JO13tGnkUdu8DQ4YNUpZzCy/Ik/
         apFkaPuPv1jsUS53nitJ39Pu4PDAP8edvP5hBx24rj2K8nF+sL+SErjU76dub7yPGFve
         2HBdLhJKtOSWIVqxg9AObzCkz8eP04rndtk/hp3VoQ1zqkzp2CuX63UJ93r5OV4/HOP7
         iUvCEf5/3VVmnyQR51lwt2PdbgwjynMj25Oeay/HGvR/TjyRCQhS37Ofh6i3n4sO/DaN
         WQ1A==
X-Received: by 10.68.68.175 with SMTP id x15mr6919427pbt.10.1439850921042;
        Mon, 17 Aug 2015 15:35:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id d4sm15791779pdc.93.2015.08.17.15.35.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 15:35:20 -0700 (PDT)
In-Reply-To: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Mon, 17 Aug 2015 14:33:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276102>

I just said v8 needs reroll in the latest "What's cooking"; after a
quick read, this round looks very reasonable, as you said in your
cover letter.  Will replace what has been queued.

Thanks.
