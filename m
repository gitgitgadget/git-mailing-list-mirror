From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] The images from picon and gravatar are always used over
 http://, and browsers give mixed contents warning when gitweb is served over
 https://.
Date: Mon, 28 Jan 2013 20:12:06 -0800
Message-ID: <20130129041206.GA15442@google.com>
References: <1359416492-8597-1-git-send-email-admin@andrej-andb.ru>
 <7vtxq0u1v3.fsf@alter.siamese.dyndns.org>
 <CAGyf7-GJkKDWdykq8iv90tU3TUR5ZKUf2bQc9sJokbq-RFYBYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrej E Baranov <admin@andrej-andb.ru>,
	Junio C Hamano <gitster@pobox.com>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 05:12:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U02Yn-00066V-TP
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 05:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab3A2EMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 23:12:16 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:59541 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab3A2EMP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 23:12:15 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so7137dak.39
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 20:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+dGyhL9TmXtPzIXa6Q1nKE8a5Bj7b+1Uuixhh/MG4W0=;
        b=r5oR7naK0l30HJDh5uyQE7KXqafSKFO4N5mpNINfRor+d7zwhJZGBtiu7JSqJW1zz5
         YvwLgQoHUeUJitksp6RhrNEqzxR/9T1rCc9ToxcXoWG/trm9zCpTNqRowQq9/vfhWnHp
         Ga+mDvyYEbADaw0sRGCSsAxnnk3Nj3jtXaKeCSzdBsf/z5iO3TbTo/WEVbHQN28rKYQJ
         qKUatdl9Ee6RvfApaIYgTtbE6J497l/qwHBXlsySIqtM9pXPErD6dDxr7UvvmJHf47mM
         wTLutmCaUkRsApb8yOwvORg1lsVllJsffDS6oSXGTqyoMgwo9olSmrNZzqvnYXT2AC8M
         4oZg==
X-Received: by 10.68.254.137 with SMTP id ai9mr536132pbd.21.1359432734737;
        Mon, 28 Jan 2013 20:12:14 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ql9sm7552206pbc.61.2013.01.28.20.12.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 20:12:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGyf7-GJkKDWdykq8iv90tU3TUR5ZKUf2bQc9sJokbq-RFYBYg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214897>

Hi Bryan,

Bryan Turner wrote:

> This won't work correctly as-is. The secure URL for Gravatar is
> "https://secure.gravatar.com"[1], not "https://www.gravatar.com".

Odd.  "https://www.gravatar.com/" also seems to work.  I've put in a
technical support query to find out what the Gravatar admins prefer.

Thanks,
Jonathan
