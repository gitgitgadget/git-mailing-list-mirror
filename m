From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2 2/2] completion: complete config variables for --get/getall/unset/unset-all
Date: Mon, 11 May 2009 22:20:26 -0700
Message-ID: <4A09071A.1030107@gmail.com>
References: <1241832213-23070-1-git-send-email-bebarino@gmail.com> <1241832213-23070-2-git-send-email-bebarino@gmail.com> <1241832213-23070-3-git-send-email-bebarino@gmail.com> <20090509034438.GZ30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 12 07:27:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3kWP-0004dV-V3
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 07:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbZELF0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 01:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbZELF0r
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 01:26:47 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:33388 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbZELF0q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 01:26:46 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2009 01:26:46 EDT
Received: by pxi29 with SMTP id 29so72684pxi.33
        for <git@vger.kernel.org>; Mon, 11 May 2009 22:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=UZ6mmR1wpaa27FVhhtIstK6tsggwLQNV+aRtSUh44js=;
        b=nJucLSxMMcmHlguozr2tc1jrYgNxaIl7Umm/ESS/b38NZ4rZ61pFpY1TQCZ16OhYJc
         AVPCdBdG94YiQIuqimyPOfcqZhN/qicfVCASh1LA5IWl9fH5jskvuT7wUbwKH52sg3yZ
         8FR72WzufNNFUgdm6oEXYum0Cd6cu5BxDD7+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=x06C4J1oYN4hVd8Tuwpm2g89rusrsF/mR0zjfp42q3phpBleqW0yrzxhVJpBQD8IZK
         NZP8pjw77LIHdfMshTFF/Idb4akCtSuzcWY5CeLfQT//64UX57MjcA1XWWUwCNV1tK8U
         onQ1fDMyn6P+mVEA2Pe158MKsrz6ehzfdxpa8=
Received: by 10.115.91.2 with SMTP id t2mr6035947wal.224.1242105629697;
        Mon, 11 May 2009 22:20:29 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id k2sm413205rvb.0.2009.05.11.22.20.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 22:20:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <20090509034438.GZ30527@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118871>

Shawn O. Pearce wrote:
> These probably could have been one patch, since the function
> is introduced only to support this one usage, and this patch
> is only 4 lines larger than the function definition anyway...

Seeing that this hasn't been picked up yet, I'm fine with this being
squashed into one commit. Could you use this combination of the two
messages for the commit?

---8<----

Subject: completion: complete config variables for
--get/getall/unset/unset-all

This should make it easier for users to get and unset their
configuration variables without having to open documentation or dig
through their configuration file.

__git_config_get_set_variables() retrieves the set configuration variables
 from the appropriate configuration file. For example, if the user has
previously specified --global only the global variables are returned. The
same applies for --system, and --file. If no location has been
specified, all
set variables are returned.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
