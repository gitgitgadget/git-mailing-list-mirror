From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH v3 1/6] alias.c: replace `git_config()` with `git_config_get_string()`
Date: Thu, 31 Jul 2014 13:13:43 -0400
Message-ID: <87bns5xxh4.fsf@naesten.mooo.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
	<1405941145-12120-2-git-send-email-tanayabh@gmail.com>
	<53CD1900.6040909@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 31 19:13:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCtvP-0007XK-BW
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 19:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbaGaRNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 13:13:51 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34808 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbaGaRNt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 13:13:49 -0400
Received: by mail-qg0-f54.google.com with SMTP id z60so4489722qgd.27
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fU6UWtab/LmtQXv7ypE8GcdoZ3qAsmBj5aGFLCwdUc4=;
        b=yFsrvwc6lWdWSN15qoZTelyanJspnZb/eezC3CLPzzWSsLWyK4vh1md1ectdWXkIqc
         eSqzlUgD0LqCWCEQwYRcBOMezNyk9riOZ4/K5r9afOks3b6Cht4BWdq5WKBzqWS9v1as
         ks+PC5V6EH53GOfMSPmLyF48eO8b8uTs9Pa2E8UW6NwErfA4CiQekAwyn0Ty+rskmV3B
         glUk1B5TPD5D5sMYXZzr9/P5J2MqSvTKfPFwNY+B2EbLZHS1GaVER2cZl/bGI+WrhHdo
         l2W2vNfhamRPVMdWvaQKlmksm/unABirkV4RN5fGDNNc9z2hlA+6wOJ8zCTO6DU9gUEu
         B4gw==
X-Received: by 10.224.65.196 with SMTP id k4mr21288257qai.56.1406826828575;
        Thu, 31 Jul 2014 10:13:48 -0700 (PDT)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id j110sm6522972qga.40.2014.07.31.10.13.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 10:13:48 -0700 (PDT)
Received: from naesten by hydrogen with local (Exim 4.82)
	(envelope-from <naesten@gmail.com>)
	id 1XCtvE-0001PP-P4; Thu, 31 Jul 2014 13:13:45 -0400
In-Reply-To: <53CD1900.6040909@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Mon, 21 Jul 2014 14:43:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254593>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> On 21/07/14 12:12, Tanay Abhra wrote:
>> -char *alias_lookup(const char *alias)
>> +char *alias_lookup(const char* alias)
>
> No, this is not C++. :-D

Why would C++ make a difference?  Shouldn't you *never* do that?

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!
