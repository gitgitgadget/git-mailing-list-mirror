From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v1] git-p4: map a P4 user to Git author name and email
 address
Date: Mon, 29 Feb 2016 06:31:03 +0100
Message-ID: <56D3D797.2040401@web.de>
References: <1456655125-17829-1-git-send-email-larsxschneider@gmail.com> <CAE5ih7-oPE1RYrO78TAnkNSi03qtcUK_iiLywoyRC_FAgdwTAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>,
	Lars Schneider <lars.schneider@autodesk.com>
To: Luke Diamand <luke@diamand.org>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 06:31:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaGQQ-0001Vd-EY
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 06:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbcB2FbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 00:31:14 -0500
Received: from mout.web.de ([212.227.17.12]:59269 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783AbcB2FbM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 00:31:12 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Mfq6i-1aFH7m0LSu-00NAhn; Mon, 29 Feb 2016 06:31:06
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <CAE5ih7-oPE1RYrO78TAnkNSi03qtcUK_iiLywoyRC_FAgdwTAg@mail.gmail.com>
X-Provags-ID: V03:K0:mtMwZLMFNNPOetP6i8lD4qfPoHAg9BoUYNon16o7JhZP7TcY+OO
 iA7KRDwTyRV+HpHnvy4P6TRAEFIQCUFlqXyp6S2JVRt+jmS8utXqeUyvm8HbTvmHC/s6wgE
 ULTDwxcOPJYAwEKvz6FNKkDjCu6dD2SC9vPqr9c4fAE5fhWlhR6cfMMutovGfFFfB2Dl/Up
 B5LDW4nTStxxfLb8Naulw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zdYNLcTUlDo=:iBoKBcj6Q82Gkd44E9mpqG
 fbj2+WcZM1uYFEk7SZ8EOjOZDiFpcbVr9P+606R4RpfVYZgUO3Ia3O3QmWuANE6Kg2BNouP/k
 RI2cpMeOUQ6jBWMmLmZDkRo6spmY315vSOXU3TUWa7k1axWVWjYdVyAg2YSfaQx48SMmG7UA4
 qdiohjSJ0xm6F2ozs+Stvfs82ppRAInf2ebHbLBFLfXhIBt0cMYbpQgoWDy6MilO+hFkjs3tk
 0Q1RUp87MamFSqVjJywmzELzLG5031P5IWpZHModMli4p9jextF5Vj3aX9ZLX8I2GXSlBw3pa
 yT13/E/DXZhdwZf0D3X8HYG4qR3sz7L/y/yAy35tavMGyhpPCCM0iHwi0K5b7VHU/BKdaoAu1
 dZuvwhmwuK/9EeZtCTHQQWSpHFWuPbBJQQTCoDupK46uwsMKgsE0v5HfAhsUXI6Sj3GY7pKy9
 j+4YVnif8EM9WJcI/+5qgzdcyO3oLnqndLt37f49g/DCgaMokwAarzN61fapk+TPvHyHFEjnQ
 p6SFgAxeE9A7VEkhfzV0UdDsWbz+pgatPV5/E3XaCUuztYq7pRzrzJLDflyeY80aCaXxtxOik
 JkdKKZT9ykB+EVTJVsSFh5C5o6xDmetyjqO6mI/9JdUrGGy0f4QStionVaZEKf2eBAnQ9xiPW
 sl7sCOs9YExmqj7dpNwN4ixVaCDQWkHFsofS7/gAmHmhUjepz7S5k+8EaEqPKlK2MWKVnmuj0
 qhTGEQEJWVoknyqhiR9se8r3OD+v22AIqqtMIj07ziCJ3ZOtsVjFjRa+8vdPLVmuBfN62Eq0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287800>


+       (
+               cd "$git" &&
+               git init . &&
+               git config --add git-p4.mapUser "mmax -> Max Mustermann <max@muster.com>"  &&
+               git config --add git-p4.mapUser "mo -> Moritz Untreu <moritz@untreu.com>" &&

> Probably better to use more innocuous names. I'm not sure who these
> people are, but they might not appreciate being recorded forver in a
> git-p4 test script.
>
>
A better name could be
Max Musterman <max@example.com>
Erika Musterman <erika@example.com>
