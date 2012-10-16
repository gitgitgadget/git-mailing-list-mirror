From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 12/12] Add git-check-ignore sub-command
Date: Tue, 16 Oct 2012 18:08:10 +0700
Message-ID: <CACsJy8Du1G-=pBbHW841V-61L9_HGmNkOE7EB2W2f1RJe9WuXg@mail.gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com> <1350282486-4646-12-git-send-email-pclouds@gmail.com>
 <7vlif7v03r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 13:08:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO513-0002hP-P6
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 13:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558Ab2JPLIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 07:08:43 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35303 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab2JPLIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 07:08:42 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so6022590oag.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 04:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u7JxIZZIqfdAd3jWu7lXYYLL1awsaGZeYrkdSooDMiw=;
        b=C6wKlwmF0MTvV4TbMkE2XAgtVp/sz2E03x08mgecowT4n8gztvoVBDnFTI2jfa0Dew
         XPlF84HWL8kMsTWPzrMNMgNGr/QJSc+mlLraBXtXN/FYDqetdpRSFgGfabXhv7obsvfP
         qrjiA1NB3mCNnqoXFM8RL/8TPZxaFRlo98Excl/agzkFuSbtopIvzZI7tuFW+HOqWiYD
         7SgheMqZFnccDDv4oEkrRtnMWWRwI0lfLf5GWSQCi3/5mAUH8nvrTDpiGRHnDPibuCAH
         Xi8qdX04S5GvKnzCiOBE+Djozq+a7QPNaS3tgK8N8VidsLe8G35o0vZAcqSsdFJysaSi
         Yl0w==
Received: by 10.60.26.230 with SMTP id o6mr11768630oeg.109.1350385720730; Tue,
 16 Oct 2012 04:08:40 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Tue, 16 Oct 2012 04:08:10 -0700 (PDT)
In-Reply-To: <7vlif7v03r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207812>

Adam, do you have time to continue this series? I can help polish it
for inclusion, but I don't want to step in your way if you are quietly
updating it.

On Tue, Oct 16, 2012 at 5:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +
>> +If `-z` is specified, the output is a series of lines of the form:
>> +
>
> Hmph... the remainder of the paragraph seems to have been chopped off.

No, the last version [1] looks the same. I was worried there was a bug
somewhere in the toolchain that chopped it off.

[1] http://thread.gmane.org/gmane.comp.version-control.git/204661/focus=206085

>> +EXIT STATUS
>> +-----------
>> +
>> +0::
>> +     One or more of the provided paths is ignored.
-- 
Duy
