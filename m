From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 03/15] user-manual: Use 'remote add' to setup push URLs
Date: Sun, 10 Feb 2013 14:08:48 -0800
Message-ID: <20130210220848.GB11720@elie.Belkin>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <44d89e81a8465d3bbf50b106a8a844c9d90ac384.1360508415.git.wking@tremily.us>
 <7v8v6vua50.fsf@alter.siamese.dyndns.org>
 <20130210215442.GB8000@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4f5L-0004PN-0N
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab3BJWI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2013 17:08:57 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:43558 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586Ab3BJWI4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2013 17:08:56 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so434137pbc.40
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 14:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cjma9fzH2XNirRTPwMPS6LqYquq92/9Zd5w36p4Grg8=;
        b=Ldcp2eccblU7t1RxVVDJt13lcKzLwCEfYDwU9oVV6G0rlQCgZLu6iL4/DgpxOyfTh1
         Q069k/hKQSZxikhZ4nJ205GHgL4LcRzpPRJb7/gUlC/2zziZXgWbk74nHj8kXUKNstCz
         fQgwIDjbPcqjhEGDTpczbFE7cR82tE/j5Y+PBokgQbPG/qPGFbIHRugahxDDV3X7RFxf
         D1lhP6uNJ6LtOFccqYDmlkZhtjs9CyOjlNrhEbsIjyW1WKibkcb769ZsBK8Wqn8V54op
         eGW/Ae2G0UGYgjnJxLpTqZL8pKc7kaZ2ZLGFgNIEyL9Nh+3u8m7OOmUNUhjYoynJTlew
         kzeQ==
X-Received: by 10.68.116.101 with SMTP id jv5mr14010796pbb.75.1360534135690;
        Sun, 10 Feb 2013 14:08:55 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ro16sm5508682pbb.14.2013.02.10.14.08.53
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 14:08:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130210215442.GB8000@odin.tremily.us>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215948>

W. Trevor King wrote:
> On Sun, Feb 10, 2013 at 01:33:31PM -0800, Junio C Hamano wrote:

>> The resulting text may read like so:
>> =E2=80=A6
>
> I'm fine with this too, but if this is the suggested route, why bothe=
r
> with `git config` at all?  Is it just for ease of scripting?

Yes.  It can also be helpful when giving help over IRC, since you
can get reproducible results without assuming the user has a proper
text editor set up, but that is just a special case of scripting. ;-)

=46or everyday interactive configuration editing, config files have som=
e
good advantages:

 - The settings are easy to read, well organized, and all in one place
 - The file can include comments.

Thanks,
Jonathan
