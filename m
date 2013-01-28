From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] remove protocol from gravatar and picon links for clear
 if Gitweb is being called through a secure server
Date: Mon, 28 Jan 2013 14:39:02 -0800
Message-ID: <20130128223901.GF7759@google.com>
References: <1359400490-16449-1-git-send-email-admin@andrej-andb.ru>
 <20130128205834.GC7759@google.com>
 <7vfw1lug6f.fsf@alter.siamese.dyndns.org>
 <20130128221026.GE7759@google.com>
 <7v7gmxuekl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrej Andb <admin@andrej-andb.ru>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 23:39:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzxMU-0005Z4-FY
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 23:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777Ab3A1WjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 17:39:09 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:38817 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746Ab3A1WjH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 17:39:07 -0500
Received: by mail-da0-f49.google.com with SMTP id v40so1459777dad.22
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 14:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SVQF6YH83XVr9S/eMQZGRbp+ZoLdPyncUOdMxXFk2tU=;
        b=fCYdSL7eNihU0LzCKgWrQS3EmQTWAebd3muBU5oaYp3Bif6avSHhI0zPAOgFAp4FwL
         SQPiN5vVofjg0fmXFTJ6Uxj9YOvHwpu1trcXt08+9OEHs9cG21dNWgbHT4iQEBSxAOCH
         7O9ce7xB0yYq4+3FG3EDl44H7NryMqppTCE47bi7upsi9iuQX26O9oqRrUGd6ZI+TOGo
         50yE/VptQ6ok4hUNW5bEol2JBTNBtG9vMypNwbwQQZdkxuBsnYA3vuhj1LG0qVMeusOC
         SfXFmUfd6qjYH90ojrzfPvbRov5YWRfmLgUMYXIWm7kNSUZGljbqJQBIkq57MGyXKVkH
         gkaA==
X-Received: by 10.68.239.232 with SMTP id vv8mr41149968pbc.53.1359412746534;
        Mon, 28 Jan 2013 14:39:06 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id t7sm7526112pax.17.2013.01.28.14.39.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 14:39:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v7gmxuekl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214884>

Junio C Hamano wrote:

> I am sure mixed content warning was the primary motivation of the
> patch.

Sure, but that's not enough motivation for me to like it. ;-)
The privacy aspect is enough to motivate it for me.

>         Do we know these external sites actually server what we want
> over https://?

Yep.  cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi and
www.gravatar.com/avatar both support https and return the expected
responses for queries over https.
