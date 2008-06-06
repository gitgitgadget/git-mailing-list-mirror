From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 09/12] Add getSize() method to ObjectIdSubclassMap
Date: Fri, 6 Jun 2008 15:24:15 +0200
Message-ID: <200806061524.15823.robin.rosenberg@dewire.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com> <1212441883-12990-9-git-send-email-marek.zawirski@gmail.com> <1212441883-12990-10-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 15:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4bzK-0007zN-6Q
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 15:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171AbYFFN1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jun 2008 09:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757107AbYFFN1K
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 09:27:10 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21512 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756969AbYFFN1J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 09:27:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0B0C480287C;
	Fri,  6 Jun 2008 15:27:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4aKA2EWW3emE; Fri,  6 Jun 2008 15:27:07 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id A1E938026F0;
	Fri,  6 Jun 2008 15:27:07 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1212441883-12990-10-git-send-email-marek.zawirski@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84066>

m=E5ndagen den 2 juni 2008 23.24.40 skrev Marek Zawirski:
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.j=
ava
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.j=
ava
> @@ -107,6 +107,15 @@ public class ObjectIdSubclassMap<V extends Objec=
tId> {
>  		size++;
>  	}
> =20
> +	/**
> +	 * Returns number of objects in map.
> +	 *=20
> +	 * @return number of objects in map
> +	 */
> +	public int size() {
> +		return size;
> +	}

Just the @return is usually enough for methods that simply return a val=
ue. If you
have both the untagged part of the comment should explain much more. Pa=
tch
10 is a good example.

-- robin
