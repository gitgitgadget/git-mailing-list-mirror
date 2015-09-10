From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv1 0/2] git-p4: work on a detached head
Date: Wed, 9 Sep 2015 18:57:49 -0700
Message-ID: <CA+P7+xqZ+MOMN6so1AVSbQdHjuWp+48jQw8gp8cxE0CaYc8Ldw@mail.gmail.com>
References: <1441461738-25066-1-git-send-email-luke@diamand.org> <6B07CAFE-6A10-481A-9D15-0DBFF6AB0B11@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 03:58:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZr7z-0007rp-Lj
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 03:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbbIJB6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2015 21:58:10 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35237 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbbIJB6J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 21:58:09 -0400
Received: by ioiz6 with SMTP id z6so44131295ioi.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 18:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7oTNi+eSV7SUn+1s5dc3DZAdQJKk/fRc70Dbrc/Xsn4=;
        b=egepRREZ+GNTvM2N2V2+xxYo0xyM/Vwgw6Rr3NvyMEmiQ/Fh03TSncoNLRogDttoUW
         +WL5HbprbeLc3c4USafSXE7t3A4NgZlEohZgwlDxZmXGXmUT6CL5mw1YN0ULEkK0e73m
         ao5XJa6GEmlhqImFnRj2IAxR8MaK2zoGoZvTIqM4Khe/SlEbbH7q0QWCRTDF5EaD3lnt
         mOUOoFCztiaKDJ9oO8V4KTZYgLy4azcwgVb1o+oavhlbKj4dH4UpuS4QQY6mQUmbss57
         scB9Ofy4EKCV6YwY8bJNLul1LE1NS/phUtIarYuGLJD7LjlRZFlVQtC93ubrkwn73M1k
         mv3g==
X-Received: by 10.107.133.151 with SMTP id p23mr64070937ioi.71.1441850288802;
 Wed, 09 Sep 2015 18:58:08 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 9 Sep 2015 18:57:49 -0700 (PDT)
In-Reply-To: <6B07CAFE-6A10-481A-9D15-0DBFF6AB0B11@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277570>

On Wed, Sep 9, 2015 at 5:03 AM, Lars Schneider <larsxschneider@gmail.co=
m> wrote:
> I wanted to play with the patch and apply it to my source but the pro=
cess is really complicated for me. I wonder if you can give me a few re=
commendations how to work efficiently with email patches. I don=E2=80=99=
t want to start a flame-war about what email client is =E2=80=9Cright",=
 I am just curious how you work and what clients, scripts, or tricks yo=
u use :-)
>
> Usually I use Apple Mail. I experimented with mutt but it was not dra=
matically more convenient.
>
> Thanks,
> Lars

Generally, any client which lets you save patches as mbox format. Then
you can feed the file via git-am

I don't know what clients make this easy. I normally use Evolution,
which has as "save as mbox" option. It's possible Apple Mail does too.

Regards,
Jake
