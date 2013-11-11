From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH 7/7] remote-bzr, remote-hg: fix email address regular
 expression
Date: Mon, 11 Nov 2013 05:43:59 -0600
Message-ID: <5280c2ff2d16d_6841541e7846@nysa.notmuch>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384142712-2936-8-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 12:51:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfq1V-0005Wp-GR
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 12:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab3KKLvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 06:51:08 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:51072 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab3KKLvF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 06:51:05 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp4so2162290obc.36
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 03:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=NjjrSTFZcWZ5+T8U168QYafJcUPjTVXk404ebPdn9rk=;
        b=kODQcdbg6xdqrc64XPg4Ei0x1L+JUhjD/hvNAteIHj2Lf/N652ssbBWlmhp3f8QlIl
         s7aeajD8PjPUhn4dg1+0bYgRXJ8Pkfv5w9DGo12gWn+F76ChEzgyyAHpmuU0BmNPLTA9
         TSQ+KV24uddXtYjTrA1XbiFcUQNKqMnyDnNLUjW4aE/9bdUfECaEOmjFSZji4DA8ZTK2
         ENwcBjjv431p1n4VRFL6Bz3rXS5IX1NbG0QVVjJMUVFevWMlIDV1oaJQTCzzhmhTZ6sR
         Qc5MRIZ70yLDD8phXsyzf3b3oyn9bGP6SAv9Sq3l9kIxWZn8fWxI2zEcTuSeuXUz1EWr
         UIrg==
X-Received: by 10.182.142.37 with SMTP id rt5mr769115obb.76.1384170664903;
        Mon, 11 Nov 2013 03:51:04 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ee7sm31809065oeb.5.2013.11.11.03.51.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 03:51:04 -0800 (PST)
In-Reply-To: <1384142712-2936-8-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237613>

Richard Hansen wrote:
> Before, strings like "foo.bar@example.com" would be converted to
> "foo. <bar@example.com>" when they should be "unknown
> <foo.bar@example.com>".

Indeed. Thanks.

-- 
Felipe Contreras
