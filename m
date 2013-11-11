From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH 4/7] test-hg.sh: eliminate 'local' bashism
Date: Mon, 11 Nov 2013 05:40:54 -0600
Message-ID: <5280c24640449_6841541e7877@nysa.notmuch>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384142712-2936-5-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 12:48:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfpyH-0000s6-MN
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 12:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022Ab3KKLry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 06:47:54 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:44312 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab3KKLrx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 06:47:53 -0500
Received: by mail-oa0-f43.google.com with SMTP id g12so3570280oah.30
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 03:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=hMwXMqAx7mALn1jPqxJ3gbWX0P8ltDuEpb57dG8/lF4=;
        b=P2HI9IcV2s4VzOW/VfiodWb0Pyf0Q8tY4vzWECP7K0KJcuC2wOFDz0DlZ4ErYYuyeF
         2GMCL0BK0UsNITbJTj0lTZ66qcNJxq7h3nH3PzMiMNW4OdUVXDAbn5H7FH2EdMsQ3kR8
         p82tLxGsFgU88/Ye4Cd53y+XE4OFGMXs5P++aVDmKXtArOB8/tWYU2p8uE7+rrKlGDOw
         YnbpH9C6hVJIZ7Pjar5ZVifyIa/y8fqmz6v1WDq4KeN9NrFQxeoP8XHFYo0QamyY8Pkv
         UConSF7UCJvY9VTCzAPLEJq+nI+iXBv5EDBnGxIWRNHvAmZIwOQ+LA/06KvYuYwvjHI0
         ntVw==
X-Received: by 10.60.63.244 with SMTP id j20mr15923812oes.24.1384170472495;
        Mon, 11 Nov 2013 03:47:52 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id f2sm31811088oes.3.2013.11.11.03.47.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 03:47:51 -0800 (PST)
In-Reply-To: <1384142712-2936-5-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237611>

Richard Hansen wrote:
> Unlike bash, POSIX shell does not specify a 'local' command for
> declaring function-local variable scope.  Except for IFS, the variable
> names are not used anywhere else in the script so simply remove the
> 'local'.  For IFS, move the assignment to the 'read' command to
> prevent it from affecting code outside the function.

Makes sense.

-- 
Felipe Contreras
