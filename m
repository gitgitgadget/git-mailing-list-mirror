From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Mon, 21 Sep 2015 10:43:48 -0700
Message-ID: <xmqqvbb3acrv.fsf@gitster.mtv.corp.google.com>
References: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com>
	<1442766131-45017-2-git-send-email-larsxschneider@gmail.com>
	<55FFB681.50500@diamand.org>
	<0BCEFDB9-9042-4D42-8775-AC22C3658F71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org, tboegi@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 19:44:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze58B-0006HJ-JI
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 19:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbbIURnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 13:43:55 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34531 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbbIURny (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 13:43:54 -0400
Received: by padhy16 with SMTP id hy16so122291457pad.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cASWBxIdPSGUVgiZDH+TnTCzHXEllnQ7rzKb9o2Ud7A=;
        b=awiARax0hXvY/CLyMdmBDwkrWhHTV4tGN0KC7sd9Xtt9XEf2O1ZHjC3aq88x3jQofK
         0VkxqvvaKwo89ICgMlp13AS0qzDVrvLkIoE20fSOpWr8nIUQDfHwYihusEvbCYXH9syB
         Zihq/TR6y3/PLILE++mopxvlXqrcgsoNm3ecyNz9ZCuYSufGhgUDiWGpxGOaR1HFOqU5
         lBcN08BHqMw7GuGvDJIxTIlydmTNS71ul6ATB54ktQTmoZ2j+iDWt0O+Y0R8mzHg727e
         INEYT+aP8zahT1AYGjwgLoyPLMxpyduDla176RRfyqglpf62v2XwfoONluc7g+5ena9N
         6P0A==
X-Received: by 10.68.234.200 with SMTP id ug8mr26358930pbc.13.1442857434284;
        Mon, 21 Sep 2015 10:43:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id sl7sm25647072pbc.54.2015.09.21.10.43.53
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 10:43:53 -0700 (PDT)
In-Reply-To: <0BCEFDB9-9042-4D42-8775-AC22C3658F71@gmail.com> (Lars
	Schneider's message of "Mon, 21 Sep 2015 11:05:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278319>

Lars Schneider <larsxschneider@gmail.com> writes:

> What OS/sed version are you using?

You should go with POSIX.1

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html
