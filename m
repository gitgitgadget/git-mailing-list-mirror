From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/9] Add stream helper library
Date: Thu, 24 Jun 2010 23:23:58 +0200
Message-ID: <AANLkTinQT6YvwkYrehAl5kGW9Ebkq1AantCap5nD8ByR@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624110112.GF12376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 23:26:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORtwM-000579-So
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 23:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631Ab0FXVYV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 17:24:21 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57931 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab0FXVYU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 17:24:20 -0400
Received: by gwaa18 with SMTP id a18so1042934gwa.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=yNqGweBBnVG2dk6vfjdg5EfG59iGZB2EVH1905appzo=;
        b=ZRLllCt0xyzQVgtq1iZqiGbwEWj7nWWJ1YK/WXzmdUXwhXWtWWwhr5i1dL8tfXJCYh
         IHFUKYzpyuYy4DNmjXHI59wlF0pfmDXXIs+ArkJxI6adfQcSa9Sx4tD/YHS1tVt7sglL
         dSymJU64rP0cOJmnQ4GmJ0YFp8kpaPoTPyNs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VKyLIq6lDDCw/xS+E8o2YEmsw+VcYKcKo3ViSr+NObxMiBrw+nIaVdi+8JVYWNDlje
         OAJLrUPTJktGv80hckQwiJwBD381t/jyU88lS2MBtnNBHIg3Tfnva1CQnWjunnHw42MV
         3ErKvnd05TNKM822/rceWNlS7YWcXFN1Z/YtI=
Received: by 10.229.225.72 with SMTP id ir8mr6004656qcb.73.1277414659177; Thu, 
	24 Jun 2010 14:24:19 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 14:23:58 -0700 (PDT)
In-Reply-To: <20100624110112.GF12376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149651>

Jonathan Nieder wrote:
> This library provides thread-unsafe fgets()- and fread()-like
> functions where the caller does not have to supply a buffer. =C2=A0It
> maintains a couple of static buffers and provides an API to use
> them.

=46ew (no?) changes since last time.
Just a quick reminder: eventually, we might be able to factor out this
line_buffer thing completely; it's quite non-trivial though.

-- Ram
