From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [GSOC Update] Week 2
Date: Mon, 30 May 2016 11:15:40 +0530
Message-ID: <CAFZEwPM_dKQMXb9UEwSENODOp0bvZCm+h9fpDCdtQbu3nmntOw@mail.gmail.com>
References: <1463947103-28464-1-git-send-email-pranit.bauva@gmail.com>
	<20160530053758.28134-1-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Pranit Bauva <pranit.bauva@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 07:45:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7G1M-0003ef-Ns
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 07:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbcE3Fpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 01:45:44 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35264 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbcE3Fpm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 01:45:42 -0400
Received: by mail-yw0-f171.google.com with SMTP id o16so154683373ywd.2
        for <git@vger.kernel.org>; Sun, 29 May 2016 22:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=uDge7UR/1rh7AXF6mp0ObBUzTNlXI4c/qzCvRM3/v5o=;
        b=y+8JYDB1fEw9GCIm5gC7/PJpS50Zx/aRH5EpuKH1O8qJKnAAAp7reZr3YrKQaURJz9
         0AD8mUigE1J14idbYors5JTVJGsNPvNrs+64En10H35htN/QQZlSo4iElntQOWdRIH91
         d07GPD2Zar+lsR5rorl7irK9FD2NKAaWMpatrlOmCToqSY0RTy5knJbu9C3O5/syHuZv
         wCDteoSFhwQm/0MPBOS3o4CFiREE6Y5jLVmJ/3AVT5nCE33iPFvD/HvZIE/FJ+/EErFI
         O2NvukioeVG3UyzpOGsrFs+4BdyXf7waMFB1sjL4yFXal8uMHzPMoetPitH7byqaVDtq
         DAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=uDge7UR/1rh7AXF6mp0ObBUzTNlXI4c/qzCvRM3/v5o=;
        b=RSwIJpoxkUkp3hsV8gMRMv+JJsRJqSmN/BtMoBY+5UAn7OOp3K4fBZyt6f5DVqIp3K
         gXYtURtLb98vSPDbj02CQfN5kkaUnVhGTW9djpsRS33YtbTCxwVNAPBt1nPZw0KSZwos
         hmpE1CfD+bVKc6uvumFCaphzb0TBl8/bsY2jK+0aGg5GPpVeBvh9c5+YdhnI3TChcw+I
         CvRqFU/EBNb995yQ5fS1zMSr2hTxDZfBiYd5PnpkNI1sdzpOXJ8QxfH6id4V8ItyrRPF
         ykpNXXSVBLIVJIxmcS37fFK/FzZxnxM/px58UBjMRKP3DsE+7iuLDiUSmCWKiYH1c/2q
         EVuw==
X-Gm-Message-State: ALyK8tIu/xBFc4STsptKTghosYVDsI5b78t7aXraQCDVGT62bIkpieUdNY+AR32MHyKtv/WEyYbj2pRWX1W1Ng==
X-Received: by 10.37.21.131 with SMTP id 125mr15891061ybv.23.1464587140080;
 Sun, 29 May 2016 22:45:40 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Sun, 29 May 2016 22:45:40 -0700 (PDT)
In-Reply-To: <20160530053758.28134-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295854>

On Mon, May 30, 2016 at 11:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> ================================= SUMMARY ==================================
> My public git.git is available here[1]. I regularly keep pushing my work so
> anyone interested can track me there. Feel free to participate in the
> discussions going on PRs with my mentors. Your comments are valuable.
>
>
> =============================== INTRODUCTION  ==============================
> The purpose of this project is to convert the git-bisect utility which partly
> exists in the form of shell scripts to C code so as to make it more portable.
> I plan to do this by converting each function to C and then calling it from
> git-bisect.sh so as to use the existing test suite to test the function which
> is converted.
>
> Mentors:
> Christian Couder <chriscool@tuxfamily.org>
> Lars Schneider <larsxschneider@gmail.com>

Its Week 4. Sorry.

Regards,
Pranit Bauva
