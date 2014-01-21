From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Tue, 21 Jan 2014 11:53:53 -0800
Message-ID: <20140121195353.GI18964@google.com>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
 <87d2jlqp7x.fsf@fencepost.gnu.org>
 <20140121165546.GE18964@google.com>
 <874n4xqlly.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jan 21 20:54:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5hOc-0001Oo-Pk
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 20:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbaAUTx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 14:53:57 -0500
Received: from mail-gg0-f170.google.com ([209.85.161.170]:63027 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbaAUTx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 14:53:57 -0500
Received: by mail-gg0-f170.google.com with SMTP id l4so2802993ggi.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 11:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=L3dQkcPwAQnVy7XeJ0ykWrhwcUcFsl/s0JFwQGV12C8=;
        b=QZiloZSVDC35SZyP7jtYiCXPiHn52kh8TDJkpvIyezRCAyNuYlPI0iiALmqYLeRv/l
         r88Qo7ZKUhGEb1yMK6cgA3TFPqPHR/YfyhRqtnPyHCkXO2i/4kg2VI70Yoilv78PPm/U
         LxTXvf2GIpT3CsZTHGU/+BH0HtPS4oA/2zhxliLAqxx/Vhh222CCMobYibqcPxmHR480
         g8keMcfhAZiojnsb9bbM80gfF8Ox3L6EtkXk1l07eVjRnBRTiMs1c+DXNq4KddANfDoJ
         Gt4i1MK2JvnnmNqWgPXyirnCZ8HalDIXL9dBz6lOBsvHJsvND7k2q5O3w955uaXmKFNK
         CrzA==
X-Received: by 10.236.190.199 with SMTP id e47mr25270347yhn.26.1390334036488;
        Tue, 21 Jan 2014 11:53:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id k76sm16053568yho.18.2014.01.21.11.53.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jan 2014 11:53:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <874n4xqlly.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240768>

David Kastrup wrote:

> The combination of the SubmittingPatches text with the file notices in
> builtin/blame.c is not really painting a full picture of the situation.

BTW, thanks for bringing this up.  It last came up at [1].  Perhaps we
can do better by adding a note to README or some similar file
explaining that git is under the GPLv2 and files use that license when
not otherwise specified.

[1] http://thread.gmane.org/gmane.comp.version-control.git/234705/focus=234709
