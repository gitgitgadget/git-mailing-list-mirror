From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Pass graph width to pretty formatting, so '%>|' can work properly
Date: Fri, 11 Sep 2015 09:54:30 -0700
Message-ID: <xmqq1te428xl.fsf@gitster.mtv.corp.google.com>
References: <1441979260-1494-1-git-send-email-josef@kufner.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Josef Kufner <josef@kufner.cz>
X-From: git-owner@vger.kernel.org Fri Sep 11 18:54:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaRb0-0005AH-Pj
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 18:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbbIKQyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 12:54:36 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34382 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbbIKQyc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 12:54:32 -0400
Received: by padhy16 with SMTP id hy16so79635625pad.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=X5B4Bbt84BgCw9yCyKle8wOqc6E/UhzDMNpk1TsJqtk=;
        b=c6LXChsjw6br9u7ABXL3ZGiH1Ci84u3XzXo3a7lIkJH69cs35vZ6nFYtZRc7LQwF8X
         vQXP600vloJavueTJIRbFAn80MY1B2mPQtG4MSsxM2yLFSc+g7D3f+AQU7We3rVkIfsM
         lLpe63nk7VZa/THnvixyVAqQesvhFf6EZ5XkdK2iHHleRRZQhaCgkaQ0k988Dek0aAGq
         qJbN6kXrcwCPw/zPX+tQFN6iseOuRudoOJyhzLlC6LCrbOdohWpw3SeXzbMEYnqPL7PR
         2jNTs2Up/mYade9/XjEPde5I0fnq2gVFUZC8LuJsANEC4TaetKZz1M0qu9lW9FMx/8kN
         R3GQ==
X-Received: by 10.69.2.227 with SMTP id br3mr98871621pbd.9.1441990471547;
        Fri, 11 Sep 2015 09:54:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id ok4sm1320435pbb.65.2015.09.11.09.54.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 09:54:30 -0700 (PDT)
In-Reply-To: <1441979260-1494-1-git-send-email-josef@kufner.cz> (Josef
	Kufner's message of "Fri, 11 Sep 2015 15:47:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277683>

This "feels" correct ;-), but let me summon Duy who did the %><
padding at around a5752342 (pretty: support padding placeholders, %<
%> and %><, 2013-04-19) for an extra set of eyes.

Care to add a test or two while at it?

Thanks.  
