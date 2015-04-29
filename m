From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v9 3/5] cat-file: teach cat-file a '--allow-unknown-type'
 option
Date: Wed, 29 Apr 2015 23:14:50 +0530
Message-ID: <55411892.7060205@gmail.com>
References: <5540D397.8020104@gmail.com> <1430312006-23323-1-git-send-email-karthik.188@gmail.com> <CABURp0qCe3aLtnwueh8Jm6Hm-AN1--Dk1NV4Y=oA5XhMsLh1Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 19:45:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnW2d-0002VB-Hp
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 19:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966353AbbD2Roy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 13:44:54 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34577 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966199AbbD2Rox (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 13:44:53 -0400
Received: by pdbqa5 with SMTP id qa5so34599714pdb.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=nBaisJ8vmtkBgjb80t2JlfefGsNzW+1vbJ5u4ulQCCQ=;
        b=Nb2xncRFVLENR+IaGqZcs1Y+o+vkqjW998O7wl0LHjmJkXLUyaiZxd/O65cwVuIgry
         Jal6ys7p+LOPusMxlKdWbL0lEWQORkCmXjKhQyvEUQ3Az3Z4WvbjZHx3Dn552C5h9d3v
         23BHTJ9oqGrZTVB0TXQdkNDbGb7aguib2piI7BYk/7+9Kh7To4J9ajvJIi7CeBifopER
         mStpEFOdzAsCJdqnrxI2DFe1mQb/Xx0dluP+hHvPVINqZZPAFzAJhuu76VUCYE0COWvT
         mVZdWmXggB/TfgSqAm85ZsB/tb1ymf+9w7cBwUc/olsh0EyhTKWqPUMUXeLBywBKtLEE
         GdMg==
X-Received: by 10.68.210.46 with SMTP id mr14mr316391pbc.73.1430329493389;
        Wed, 29 Apr 2015 10:44:53 -0700 (PDT)
Received: from [192.168.0.104] ([103.227.98.178])
        by mx.google.com with ESMTPSA id ia3sm25959061pbc.31.2015.04.29.10.44.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 10:44:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CABURp0qCe3aLtnwueh8Jm6Hm-AN1--Dk1NV4Y=oA5XhMsLh1Aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267987>


On 04/29/2015 08:23 PM, Phil Hord wrote:
> On Wed, Apr 29, 2015 at 9:01 AM Karthik Nayak <karthik.188@gmail.com>
> wrote:
> >
> > Currently 'git cat-file' throws an error while trying to
> > print the type or size of a broken/corrupt object. This is
> > because these objects are usually of unknown types.
> >
> > Teach git cat-file a '--allow-unkown-type' option where it prints
> > the type or size of a broken/corrupt object without throwing
> > an error.
>
> In this entire series, replace all 'unkown' with 'unknown' in both the
> commit messages and the code ("unknown" is misspelled most of the
> time).  I notice the switch name itself is misspelled, but also
> variable names such as 'unkown_type' in this patch.
>
> Respectfully, because I know English is a challenging beast sometimes,
> and spelling is difficult even for many native speakers...
>
Thanks for that, Yes it does get a bit tricky with spellings, will find 
an editor with spellcheck and avoid nano :D
