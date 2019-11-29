Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0CFC432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 10:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F181217AB
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 10:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="ADErm6f/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfK2KE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 05:04:57 -0500
Received: from forward106o.mail.yandex.net ([37.140.190.187]:43994 "EHLO
        forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726822AbfK2KE5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Nov 2019 05:04:57 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Nov 2019 05:04:54 EST
Received: from mxback26g.mail.yandex.net (mxback26g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:325])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id 17CE85061BFE
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 12:58:09 +0300 (MSK)
Received: from myt6-4bc43443fff3.qloud-c.yandex.net (myt6-4bc43443fff3.qloud-c.yandex.net [2a02:6b8:c12:25a9:0:640:4bc4:3443])
        by mxback26g.mail.yandex.net (mxback/Yandex) with ESMTP id cWGDA47p1I-w8wuMucr;
        Fri, 29 Nov 2019 12:58:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1575021489;
        bh=sY/oyW81Iwlf2j9VTb3jZdFO5FxzurMswvuohYTAhY4=;
        h=Subject:From:To:Reply-To:Date:Message-ID;
        b=ADErm6f/YK0U2j6+E22HLWrmp8MHyxmR48Ijg0PcjCMe8hCpY9oOeW/tIgtoSye89
         DKEk8h30iG37Q0eACERm3f9jnDpejkhEgk860h+ZjKC2NDpfK5Zw/TO8wL4QrssE75
         p49BXGsMD6IuBrbGXu30sBTSpUQt99hjhG1SxT6M=
Authentication-Results: mxback26g.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by myt6-4bc43443fff3.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id CHNlju4wtp-w8VSdvsK;
        Fri, 29 Nov 2019 12:58:08 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Reply-To: n1dr+cmie1408@ya.ru
To:     git@vger.kernel.org
From:   Vasilii Novikov <n1dr@ya.ru>
Subject: Dialog "compressing ... Success" is not closeable with Escape key
Message-ID: <87aae9e5-23aa-cb76-08ec-48bab0fc73f2@ya.ru>
Date:   Fri, 29 Nov 2019 10:58:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------4248DF8604C896DD96206B1E"
Content-Language: ru
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------4248DF8604C896DD96206B1E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi. It would be very convenient if the "compressing ... Success" dialog 
(see attached picture) would be closable with just Escape key.

Additionally and independently, it would be nice for the dialog before 
that to be closable with Escape, and maybe that Enter would act as "OK".


Raised on github initially: https://github.com/prati0100/git-gui/issues/17


-- 
Regards,
Vasilii Novikov

--------------4248DF8604C896DD96206B1E
Content-Type: image/png;
 name="2019.11.29_10:36:20.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="2019.11.29_10:36:20.png"

iVBORw0KGgoAAAANSUhEUgAAAlQAAAEfCAIAAAAIjc9MAAAAA3NCSVQICAjb4U/gAAAgAElE
QVR4nO3dd3xUZb7H8d/09N4JhCRApIQmERFEOgEF410XUIrZtbB41bWALioqoiLl6rIreLGL
e9XooijSLIiCKCBSQgshQIAUSCVtMply7h9DxmwyM0QBEc7n/eIVJs885zm/c2aSb54zZ85o
FEURAADURHuxCwAA4Lemb/Z9xoLsi1IHAAAXyIoZqc1aNK7DnhkLsvUGY3BwUJCfwdfAjBAA
cGmz2hWbQ6mqs54+XWWzNjSNwDPhl7EgOyDAPyosSKvVXLw6AQA4/xwO5VR5VU1NrSv/zhz2
NBoMYSFBdofYHR7Pf/muU7qI9D+49jcoFACA8ygsJMhiaXB9qxeRjAXZQUFBVnurTvtsaF03
AAB+V3x8fDMWZDsnf2dmfhqdscHmvveu1FFNv93W+cy3PbLXXMAaAQA4r3QGk+v2mfBzaHSt
nPm5/NL+AACcFzZLnbmqxCcw3OAT4Gq01tfUV5f5BkXqTX5ul1KavLvvTPh5SbIO21c5bxy6
8vqm3zbIWcLPXFFceWKviITEd/UNjTnrxgBu7fvuY1GUjmmjDCbf334VpccPnMrf17bLNYFh
Meerkgu0RaeO7ik9cTAsNikmuaeIHN653moxd+wzUqtr/o4m4PfjxPbPvNwbf+UNLRttlrq6
/B8G92r77c4tusiuPiHRIlJfedJesndgz7Zf7/jeL+FqT/nn0hh+ttZO41rZs7Y0XypzX7x3
qOJQHntlvcVS7x+R0MpVQIXM1WUVhbn1NeUOm1VnMJn8g0Oik/xConO3rNj55lStVjP8/nf8
2g8ozPnBUlsZl9LP38OfU57G8bLqZqvQG38OpLIT+2++0v+eOdPufWH1N99976nbL+Jldeei
9Nje2waE/fmGae9/uWfJ5zvN1eXL/jY8Jsz/+hlZ0V2HkX/43bI5lB9evcPtXVff+ZrbxKmt
LB3co+2MiQPGDa28+3/WOM9E0ZbvW/zQqISYELtj0zf5ZX5hZ/nJcs38PPZ48u3G4H3D+d+Z
b2ff5jGuzRUFUn7o5emjOsSHi8hLD46atnBtleh9Q9t4rwbqVFmwP9G/csZtPXt2jAnwNVVU
m/fnl37w9cGD5WLyD9uVd1Kv1YjB78SB79/52/Au7SPvfWH1/jLxC2mef17G8Q32mH9NV2FT
tErjz4LDbmsoP5o5auKx4tOb959suojVLornH5nWO1/jiEjT07TtDgmM7vDOml3P/WXo+CFX
fLTzcHBsp/OzGuB8szu83eU2m/QBUV9u3zR+WLf2sSGLHxz1lwWrNRp5afrohJiQo0WVX23P
NyUM8BRqruOeZz/s6YmnRSxVJ6Vs/9LG5BORDvHhSx5Kn7pwTY3oTEHe/gaHCtWWHh3Q3vHM
1AytRlNZXb8ztzjI39SvW3yNuWF7Vk5Ep2tvm/OxiER1Hmwr+ca11Knc74PiugTGdGrlOFrf
0KJdq0QkrucYjVZ3+kR2zam8wOiOQW26Nl2FQ2N0ND6xa0uPp/dNCvAzvvdltk9ogvXkQde6
ivd/67BbfULiQtp212h1IlJ+eGtDbbnD1qDRGYz+ocHx3fSmABGxW+urCvdZqkscVovO5B/a
vnfTbbdY6osPbLRZaoPbdAuI7mBvMJ8u2NtQU6o47MaAsOD47nqTv4gU7PhEFCU4vltdab7N
avYNjg1J6KXRaEWkoa6y8tgOW32NzuArEuYc1qGIMSjm6x3ZFqv9D4O6vP3FR35RHcuPbDNX
FDhX1OwhsNZVVhzbaauvNgVF6fSm2tKj/pFJIW27u63f6Bd6fh54QEREbA5FRHr96dVm7Tve
vNPmUNwHjcZoD0/98/Orl04f2bFt+LJZN4pIVKh/7vGyqQvXSUSqXWO0e0go1xkvZ8LPyxsY
Hr7lU/d3eFiksij31fuHdmwbfvB4Wae24SLivDF/2tC7Fm0K9Y/ytCKokGK32cpyHn30Vq1G
8+W2w4+98rVNH6jYrX56a0rHZGNY+4Idn+x86y/Og4SfzB3fPjZERP754GgRWfTBD+9vP+gX
1fGs4xhC4mtyv9y9bJqI9L3zNQmIvy89buLIEW98tuOVDXvrSg65VlEfc43WcOZoSV1l8XU9
e4nItv2FWr92rpr7p7a9fUzv0ACfz7flzf9wk1/7AdX525+bktqzQ3RIoG+N2bI779T/ZG2p
CuwpGq2hZNujf+id1vm68GDfgpLqx1/fVNJ0+4t/XPHMje2ig194//sPftwb7Dj11IS0PlfE
mYz6XYdOzv+/zVXBPSoOfuM8TLrw3c03XTc6Oizg6+1Hnnl/c0D7ftbaijbKwcUzRyTGhnyX
fbysyuwc1aEoVkXXoPHbf7SkZ8eYhAif47nfPzOle3rfsS+8//2HO3P9In/OP2tdeaztwD//
NiwpLtQ5yB8Hj3r/yz0vrt7lG9mhZf0nqpP0fiEX9FkBVbE5znyN6n69q/HU7lXORk/ZpPGL
aAjtdsf8tW/NHJ0YFyoiR4oq75i/1hGeavSL8JJozcPP5vnYi37dZBGxjXzHdfvnoke+42ZL
rFazxbYj9+S9L36+aclkEfnz3NUvPTDC3GCz2WxeVgQVslaXXtkpOsDPKCLz/u87Q7trlYr8
+tJDVSLbdu4L7TqmaedPN+VMGtk9LMh3w09HC0qq9hfWa02hzmeU93FCrkh3DaIo//FBJs0u
6mCzi7bxsIjNfLpTuwgRySuskOiurj733tx3c/axa3sk/Nd1nU/X1L/81QFbfXVSm7BvduYX
l9ekXRF3Xc+EmLCACXPWGHWON58cmxgbcqz49GebDibHh0WF/XxmWpC/6fm/DG0XHfxi1g//
t7FQb6995amxCTEha7ccKqusu2V46mt/uyHj0eWu/lNG9Vjzw6GbBl4xZkDKln0FXx4+LpU5
i+ePDwvy3X3opF6n/cOgzmc2yiE2u2hNQYcLKnp2jOmcEJm/8+fMdd57Zm847JYTPy6ePy4i
2G9nbrFGI00GUcz5m1vWf6Sw/uffH8A5c15Zxe5QmqaD28ZmrA2WQIPWx3QmxXyMOqNBW91g
0XpPmcaLmDWGn4cLu/h8MaVph2Yvmrtdyie229RFG0XEXn/m79DS0+aJz38lovGP6+ppRVAn
m9USHuQrIlab42RFnVFz9N4R0beNGi4iDTZ7n9tfa3pO8Rtr9g5LSwoL8l2+Yd93eRZjWJLO
P8L5jDrrOIG+BucgLcJPkf94tUxxND5FFbs12N8kIrXmBq3oXN2eev3rjfsrru2c988HR48Z
kPL35e8HdBg24ckVlgaLXisffLX363/eltIuPEDfcOUVcYmxIeVV5nFP/ttqinZYdvlFd3KN
8+K9I9vFBP/9gx/e+abQEJpwTVRpQkzIoRPlzy3bKCIJsSEDurcb3qfdim9znP3nvPnNxn2l
eq1m4sjunRMiVu/KG9g5JizIt6Si9rbnPnUo2qXTR17dNV5EHCI2h6Jo9dXmBhEJDjBpfUL/
venYd7uPHzglWv9Y14+hrfpUvy4xEcF+pypq/zR3pUN0Lz8w/JrUtiJibzD37xzVsn6NfyQ/
xfCkLHuV2/bw1OvdtouIw3Hma9PnldvGpiyVBcH1eW8/fkNseGBeQYWIJLcJffvRGyY/89lp
h2IK8Xx+ie7M/2ef+bXsUDNkWcD6KZ6W0viEByRdJyLle8/sBbsiwUnXtXJFUBWHxlhWVSki
Br02MsS3Uh+483BF1Pe5o/p1dNNb9/OMQxuUoPhEuJ5Ov2gch6JoG+d3jv98sd3mEI3rKarV
15ob/HwMviZ9bZNXz/MKKwxR3Q4X7hGRiGA/rWJtKPjxofF90vt2CAn0cXULDfJtExkkIodO
lNdrAkzRvUTE5vh5nHYxwdV1ltWbD+kirrTVlcRFBolIh/iwbxf/ydUnISZEGtMy90S5xj/a
mWe+PgaHzRIVGiEiR4orFWOIzhSce7zMGX6KQ2x2cdjtfj4GEakxW8UYvKPY9lN+lc4/WhsQ
6KrC1mCOCvUXkaNnBgk6XFjhDD+H3eq+fgdXvYdHdkVy372rWWPHW1/x8pvfeYTSrpw51Nns
LrcLKnaLrvLgK7Ouj4sIzCuomPzsKo3IsseuT24T+sqM9FvnrLL6RWh0Hg5QNAs/73/IVQ9Z
1uxGa5bSGv037j7hcDi0xgD+UIRbWr+I7TnZNeaGAF/j9An9Zr32zfpyU37BSffhJxrntEyj
1dhO52uM/hpjQCvHqW+wKopoNBLoZyqrKewQ38NtPU2fqBpT4KGCishQ/3bRIXvra13tSXGh
Bfv3JHYOFZHS03V2RTe6R8iEYd3yiysff3V9rdn6+syxWq1GI1JQUiUiyW3CTI7qhqKdirXW
FPHzi20rN+WMGZCy9JEbbnvm01r/DoUlVSJyuLDi+Xc2ufqUW0yuwzR2h6IRzc/TVo3+VEWt
iMSEBjjqKxVbfWzj4IqIIuJoqG4fEyIiucfLFGnTPcoSG2g6UFJ1vMFfYwxsHMP3ZHmJiCRE
B4ulwm6pSm7TeIBXa3Bbv+IbJRoufw/33H46uuL1M9Odd7aMTC8LWqpOjU1LSG4TmldQMenZ
1ebAziIy+dnV7zw2OrlN6PA+CSsPlJhC472X2qp3/wSun9I09gLXT2nNUn5xqXe88K1oNH5x
3VrTH2qk1VsCOz7/zqY5dw4Z1a/jVV3iD50oCwty/wYdjcFUXFbTLSnqrrFX9s0t/veW4yca
2p7Jv7ONY9P5Hy4sT24T9vSdgytr6tM6x529NP+o73Yf69ctvmfHmOyt5a72p24f9H328QE9
2onIZ98d1PqG6rUaEVEU8TMZhvROdH00yua9J48UVSbGhnzw9M0/HihsHxv6zle564+fGeef
/96q1Wqvv6bjkofSb5+3anOV7tjJ00lxof91XefcE+XRYf79u7d74o1Nzcty7Q29zw/7iiqq
ze1igp/+87VlVeYhvRN/vltx6K3VXRMjy06bcwqqxMc4/g9d0vt2eOH97/+17ZQ+7Ez4af0i
f9ifXXq6Ljos4J3Hb6yqtfTt0qZxb/tu3neqZf2bjivaAK5ZAY863LL0Qi+i9w9fs3WLiHy+
Ld8S3NkYFCMidSK3zlk1Ii1h7bZ8fUzfsw5yliMYrswLXD/F9a/ZXZ4Y/MODO14X3GGgwT/8
rHVAtXQh7Vfvs9/x/Cebdh8z6LW9UmL9fAxfbjs8/aUvjHF9mvbUhiS+vnp3XkFFl/aRE0d2
j/GzKNa6Vo5jiO7x9JsbjxZV9uwY4+9jXPN97tkLC2q7cnOuxWpP75tsP33M1f7S8q09O8Ua
dLoV3x5Y8tkBY9yVq3eUrNqcGxXqf//4q0+UVJktVmdPR2SPO+evWbkpx2TUjxmQEh7ke6rs
tGscReTJNzdt3V/QLSnqxXuG2bW+d81fvfr73N4psVMzrhzQvd1POUUnKjy/B0qjsUX2vufF
NQeOlQ5LS+oQH/bZ5p/fjGGvPTWgexs/H8OKjQc0ge08DqLV2SOvvOeFNQfySzu1DbdY7Z9u
yhGRBptdo9Epsf3c1K/38TgaVC+s2w1u//2KRbwsqDP6KTF9V+b42KLSnMknIsagGFtU2soc
HyWmr854lsu7iPPz/DIWZBc2hHnp1HKqd9bkA34RR12prfyQUl+hOOwavY/WJ1gX1NY5w6jP
WSmimJKHa/S+jvpKa9EOpaFGRDHGX61t8c4ZL+M4zOXW4p2KzaL1C9dodfaqAn1YB31kl2ar
aDqa7eTu+0fHTUnvkfnsij3mpIZjm0UUQ0wPW9khxd6gC4w1RKeKRieKw1q8015TrNEZdMHt
beUHxWE3JQ7RGAMUW72tZL+jrlSxWzQGP0Nsb61PyM+r05kaTvzgqCvV+kcZ21yl2Cy2Umfn
Bo3epPUN10d21uh9m5ZnK82xleXogtsZYnqKiKO+wla822Gt1fqFa3RG++njupBEQ3Rqw/HN
r97fv0v7yNHT362LGqjRGa2F2+3VBfrIrvqw5P/cZVZjxe7q8lOKYhPRvP3Y2F6dYue8+c2K
fXpdSHu39V/IJwJwYcUZy52f6tCq8ANUSnFoyveESll9cJdabZhGa7jYBbWWYjVHNByor6ms
DumjNQV66Wkt+um5yakGnePgsbKuSVHX9UwoPV33X4/+2xw9UKO7ZLYXaCVX+HHFP8AzjVYJ
61Zmqxet4RJKPhHRGHxL5QoJ12r1Z3lTnsYneO/h4kkju13Xs31FtfnzrXn/XL7NHNab5MPl
jfADvNJoNYazv37wO6QxtOqS2frQ5He3573zxb8Vu0WjM2p9w/QRvVyn0QKXqzPh968/1nrv
B+DyFSPS7AROfiHg8vTwJ2du8H5VAIDqEH4AANUh/AAAqkP4AQBUh/ADAKgO4QcAUB3CDwCg
OoQfAEB1CD8AgOoQfgAA1SH8AACqc/mEX2lpaVVV1cWuAgBwCbhMws9isfTv3/9vf/vbxS7k
fMrMzExNTb3YVQDAZegs4fevf/1r+PDh3bp1Gzly5J49e36bmn4n7rvvvpSUFIvF4mpJSUmZ
OnXqeVxFQUFBSkrKk08+eR7HdGpZvHcfffRRSkrKqlWrznHMC7dFAHAeefs8vw8//HDOnDkh
ISFDhw7dv39/QUFBt27dfrPKfhGTyZSTk3OxqzjP/vGPfzQ0NFzsKgDgMuRt5vfmm29qtdr3
3ntv0aJFa9as6dOnj4gcOnRo8uTJvXv3HjNmzMaNG0Xk73//+0033TR69OgpU6Y8/PDDaWlp
GzZscM4A7rvvvnHjxvXp0+fZZ591OBwi8vXXX6ekpMyaNWvMmDFdu3Z98MEHRSQ3N9c5Znp6
+sqVK51r37p1a0ZGRmpqar9+/Z5++mkvjVOnTk1JSUlJSbn77rtdxaekpEyePHnSpEm9evVa
sGCBs/Grr74aPHjwtddeu3DhwpSUlPfff9/thq9atSolJWXdunUi0r1795SUFOeWiojZbM7M
zGw6ptvi3Wq565xOnz596623pqWlufbSkiVLUlJS0tLSBg8e7OrmdkV2u/0f//jHkCFDevbs
OXHixJMnT3opvqUPPvhgwIABw4cPP3jwoKtx0aJFgwcPTk1NHTRo0JIlS7zskJY9PW2R255u
H83W708A+NU8hp/ZbM7Ly+vSpUtSUpKI6HS68PBwi8Vy5513HjhwYMqUKQ0NDdOmTcvPzxeR
nJycYcOGbdmyxeFwhIaGrlixwjnIV199NXbs2LS0tGXLlm3YsME1+PLlywcMGPDEE0906NDB
bDbffvvtR48evffee9u2bTt9+vRdu3aJyMMPP1xXV/fcc8/dfffdzl+gnhozMzPnzJnTchN+
+umnjIyMlJSU119/vbCwsKamZsaMGXV1dTfddFNWVpaXndKjR4+5c+c6p7lz5syZO3dup06d
nHf9+OOPycnJERERzjE9Fd+Sp10nIuvWrUtISIiJiVm2bNn69etFZOjQoXPnzu3QoUPTh8Pt
ipYuXbp48eLY2Njbb7/daDSWlJR4Kb6Z4uLip556ym63Dxw48L333nO1b9++fdiwYbNnz05O
Tl60aNGWLVs8jdmyp6ctctuz5aPZ+v0JAOfC42HPmpoaEQkLC2vauG3btsLCwpkzZ2ZmZl5z
zTWTJ0/+7LPPRCQ8PPy2225bunTpyJEjFUUpKSlx9u/fv/+kSZMGDBiwfv36TZs2DRkyxNk+
ceLERx55xHn7iy++OHny5COPPJKRkTFo0KBvv/32008/7dGjh8VicTgcVqt11KhRERERzs5u
G/v169e7d+9Zs2Y124RevXrdfPPNlZWVO3bsOHHiRE1NTW1trbP4wMDAhQsXetr2+Pj4+Pj4
DRs27Nmz58YbbzSZTK67unbtOmvWrKVLl77wwgsnTpzYu3ev2+Jbjul212VkZIhInz595s6d
u3///oyMjM2bNw8bNsw5kf3000+PHTvmXHzTpk1uV7R8+fLIyMi33nrLYDCIiN1u1+l0nopv
ZsuWLXa7/a9//euECRMMBsObb77pbH/55Zf9/f0bGhqioqI2bdq0f//+vn37uh2zZc/4+Hi3
W+R2zJaPpqfN9LQJAPDreJz5BQQEiEhFRUXTxuLiYhFp166diCQkJLhaNBqNVqt13tBoNDab
zdnf+RvN+bW8vNw1jnMEp6KiIhGZN2/e1VdfnZ6eLiIFBQUi8vTTT2u12pkzZ1577bVPPPGE
s7PbRk/8/f1FxJkKNputtLS0WfG/gvOvAR8fH+eYnopvydOuE5G2bdu6vjbdS015WlFxcXFi
YqJzG0VEp9O1flucD25iYqLrq3Ojnn/++T59+qSmpt5+++0iYjab3S7upWezLfLUs+Wj2fr9
CQDnwuPMz9fXNzk5ed++fUeOHElMTLTb7adPn46OjhaR48ePi4jzqF10dLQr6lwURXHecPZx
fg0NDXV10Gg0rtvOMe+6665+/fo5W5w9hw8fPnz48Nzc3AULFmRlZU2aNKlTp05uG1u5qc7c
OnHihIi4ZlReOOPctS1ueSreU89mu855V2Fhoetrs6n2WVcUHR195MgRq9XadObXyuKdIzj/
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
ZQAAAABJRU5ErkJggg==
--------------4248DF8604C896DD96206B1E--
