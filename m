From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 2/7] pack-protocol.txt: Mark LF in command-list as optional
Date: Wed, 1 Jul 2015 11:46:24 -0700
Message-ID: <CAD0k6qRosOZqnmQ=HW6FWYV5pi-HYCK0wYgHnpQkD5R5eRSoug@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-3-git-send-email-dborowitz@google.com> <CAGZ79kY-T8k7GjCUxKh5p_bf_t1+M8jRoBPDFp0hpExYmE8y=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 20:47:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAN29-0006In-OK
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbbGASqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:46:53 -0400
Received: from mail-vn0-f47.google.com ([209.85.216.47]:35481 "EHLO
	mail-vn0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbbGASqp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:46:45 -0400
Received: by vnbg190 with SMTP id g190so7931098vnb.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Xd+xJbV+5tNJseb+yCHMizw71vAh3PPYu3KMDIwL3So=;
        b=j3VnMVZN3QXg46/Qu5aPuN99pY6RfbxmmEP9ggZYVVrzDQPcYMCAWrhDWrdYbCDirM
         aOes5hRhbNpAY3eiI6H/oZInYOTvbeJffCfIzZLPi5Rp5z4QZlNVkMtZvVSfPKwtRgba
         KG8i+3w+ZRSZ4+XWFXx/Tz9sDOFVYYtYti4Dqt5xBUO4S4yYq3hcPIbW+JLiCeXY8CUJ
         9jDIONyP+VlsNH69DHCB2bnMSAttQEAbcHmVeuvp2COe4/tmi5Ix/9Pjl0NGB6ReOsxi
         aECFTH9Hu0O7atU7DDFaSHZbMsjrAu6Ek2OF+rDyAbew4ytIGyVTAM7WY2i1Ae3yPFyu
         7EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Xd+xJbV+5tNJseb+yCHMizw71vAh3PPYu3KMDIwL3So=;
        b=gtuUODhOp8v3YFRqgIG/Z1WEZFVf3ZI0ryFPJf3m9a64doEwsEln9dvwUka3fRI4Dx
         0/Lc7OtAhKhS04RNFzCFBE9Cg1edk4OXtA7cgWjP3PhSBKCtlUYKrosqK2EdP7KPQCUu
         0Ujftau9iPvH5tbccP7vFIufcfixA5yQXbecBRWriHEooENVkGQpA8Y08OnchOPNtOWv
         I6u4rEBqBvOcHNQ0nDuLgotPSnOsXgFZpsuQbqD1JcpSJN4D+svKqS39vEVqSqXSHfpm
         cYu0CbOk+D8bVuIfxzTCI9nNQcPetVtiIqKRC+IKEr+bpV4qWbZAgmO1U8izWRiawRhc
         y7xQ==
X-Gm-Message-State: ALoCoQlI3VYJsqZQn8wdvPEKLM7dJTZWWt9kOIdR6hyUvSX15Y5nToLa6ICQuG27fgCudjILYubu
X-Received: by 10.52.52.114 with SMTP id s18mr27858193vdo.9.1435776404505;
 Wed, 01 Jul 2015 11:46:44 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Wed, 1 Jul 2015 11:46:24 -0700 (PDT)
In-Reply-To: <CAGZ79kY-T8k7GjCUxKh5p_bf_t1+M8jRoBPDFp0hpExYmE8y=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273179>

On Wed, Jul 1, 2015 at 11:21 AM, Stefan Beller <sbeller@google.com> wrote:
> I think the problem with this part of the documentation is its ambiguity on
> what exactly we want to document. The sender SHOULD put an LF, while
> the receiver MUST NOT assume the LF is there always, so I guess it's best
> to mark it optional from a receivers point of view.

To be clear, this patch is a partial fix to one particular spec in the
file. See 1/7 for the general warning not to trust these. Auditing the
file completely was not the goal of this series.
