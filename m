From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH 0/2] Remove tabs from howto documents
Date: Wed, 31 Jul 2013 19:01:10 +0200
Message-ID: <20130731170110.GF19369@paksenarrion.iveqy.com>
References: <20130716180158.GA7524@bottich>
 <20130731165406.GA11219@bottich>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Ackermann <th.acker@arcor.de>
To: Dirk Wallenstein <halsmit@t-online.de>
X-From: git-owner@vger.kernel.org Wed Jul 31 18:58:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ZjP-0001Zk-Q6
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 18:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760580Ab3GaQ6c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Jul 2013 12:58:32 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65146 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760518Ab3GaQ6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 12:58:31 -0400
Received: by mail-lb0-f174.google.com with SMTP id w20so771918lbh.5
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O6whqTF84wIPflrVxt7KA/FdbJS4tLEOZPDdVR9j6xM=;
        b=S0H20nfDtPprANLdU4jCZ/ezQIQjVbnN2NBTSuzvQl3wy3BVONyQ5BGNhO25gdXFzr
         ctVHgWW2N3fjPVCBVKhWMJpODZxPOYhG53U7x57fowMsXy6SV7747C9mrDyMqO/9VJqV
         ygyaEJpMQNvcVxSlC5boU5jvpmr9uPa5NOhs3hPhB8vNOrjlUKPE/tUycTIxSsVdjEsQ
         wigvlgqfITdFly4iK6a+fQsUMy0dLIBgieGG2IY9aDdsbMduWH6JZnscvcio7iwXZtFv
         1oN9dmxGrASnsMTGLfOnVilT6jkb0u7PydC2wsN8csjr4TiVustpUtqCH/XjxmgWmkJh
         cxlA==
X-Received: by 10.112.143.162 with SMTP id sf2mr29295209lbb.1.1375289909541;
        Wed, 31 Jul 2013 09:58:29 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id rx1sm1690366lbb.0.2013.07.31.09.58.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 09:58:28 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V4Zlu-00046d-DB; Wed, 31 Jul 2013 19:01:10 +0200
Content-Disposition: inline
In-Reply-To: <20130731165406.GA11219@bottich>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231433>

On Wed, Jul 31, 2013 at 06:54:07PM +0200, Dirk Wallenstein wrote:
> I really think that tabs are generally bad here.  So, this will
> remove all tabs from the howto folder and prevent indenting with tabs
> through gitattributes.
>=20
> Dirk Wallenstein (2):
>   howto: Suppress indentation with tabs
>   howto: Eliminate all tabs
>=20
>  Documentation/howto/.gitattributes                 |  1 +
>  .../howto/rebase-from-internal-branch.txt          |  8 ++--
>  Documentation/howto/rebuild-from-update-hook.txt   |  4 +-
>  .../howto/recover-corrupted-blob-object.txt        | 50 +++++++++++-=
----------
>  Documentation/howto/revert-a-faulty-merge.txt      | 16 +++----
>  Documentation/howto/revert-branch-rebase.txt       |  2 +-
>  Documentation/howto/update-hook-example.txt        |  8 ++--
>  Documentation/howto/use-git-daemon.txt             | 10 ++---
>  8 files changed, 50 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/howto/.gitattributes
>=20

How about adding a line about this in Documentation/CodingGuidelines?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
