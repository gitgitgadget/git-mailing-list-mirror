From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: How to create tags outside of refs/tags?
Date: Mon, 21 Feb 2011 18:21:57 +0100
Message-ID: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 21 18:22:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrZSq-0000l9-1m
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 18:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab1BURWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 12:22:19 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54292 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1BURWS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 12:22:18 -0500
Received: by qyk7 with SMTP id 7so2154336qyk.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 09:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=jhEeWx7CTZ5NKnwS0u1zR3zb6FcA0lMIMC8Wn5H+ryw=;
        b=vVV2QgfuQBlNvYXwfH0Thdj0UhShnGHhibDzhq6WGcl3YJXmu9G20T3tKZ1iKKi87X
         8C+/HKNyeiLXe1g4igQj1nvGC5wa8oEN76lxP6momOj+khfgpQHzL6taLRotNa+31d3H
         /1vzm10y0YRBmRMxXQf8IBUJy+BCS0ZuIQKRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Nh62O9TIqA35DtJEA4SBOLWH+BegIA7vXJSc1jOcrY1MqfMNgN82FXdpW0So9gNSFq
         7LNoL76FmoERSJ4jfPtWTssJA5ZMemwTL7N3DJfJYKzJsMRUVgO/sB57MGRrigUgNXqq
         U1guZRPLUfSYbj4bAGVp+dZQUoS3lcsdovfc4=
Received: by 10.224.80.200 with SMTP id u8mr1346641qak.7.1298308937323; Mon,
 21 Feb 2011 09:22:17 -0800 (PST)
Received: by 10.229.50.6 with HTTP; Mon, 21 Feb 2011 09:21:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167495>

I would like to create a tag which full name is not starting with
refs/tags. Is that possible with 'git tag'? If not, is there any
other command to create such tags?

I would like to create such tags to mark released states of my sources
which should never be garbage collected in case no branch is pointing
them anymore. On the other hand these tags should not pollute the
namespace of normal tags, means: don't want a 'git tag' command to
list those technical tags.

Ciao
 Chris
